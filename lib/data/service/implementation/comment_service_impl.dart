import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/exceptions.dart';
import '../../enum/response_data.dart';
import '../../models/comment.dart';
import '../interfaces/comment_service.dart';
import '../response/response.dart';

class CommentServiceImpl implements CommentService {
  final FirebaseFirestore firestore;

  const CommentServiceImpl({required this.firestore});

  @override
  Future<Response> createComment(Comment comment) async {
    try {
      await firestore
          .collection('posts')
          .doc(comment.post!.id)
          .collection('comments')
          .doc(comment.id)
          .set(comment.toJson());
      return const Response(data: ResponseData.empty);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }

  @override
  Future<Response> getCommentsByPost(Comment comment) async {
    try {
      QuerySnapshot commentSnap = await firestore
          .collection('posts')
          .doc(comment.post!.id)
          .collection('comments')
          .orderBy('datePublished', descending: true)
          .get();

      final comments = commentSnap.docs
          .map(
            (comment) => comment.data() as Map<String, dynamic>,
          )
          .toList();

      return Response(data: comments);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }
}
