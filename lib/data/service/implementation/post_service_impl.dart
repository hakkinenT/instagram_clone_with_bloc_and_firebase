import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/error/exceptions.dart';
import '../../enum/response_data.dart';
import '../../models/post.dart';
import '../interfaces/post_service.dart';
import '../response/response.dart';

class PostServiceImpl implements PostService {
  final FirebaseFirestore firestore;

  const PostServiceImpl({required this.firestore});

  final String _postCollection = 'posts';

  @override
  Future<Response> deletePost(String postId) async {
    try {
      await firestore.collection(_postCollection).doc(postId).delete();
      return const Response(data: ResponseData.empty);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }

  @override
  Future<Response> likePost(Post post, String followId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> postDoc =
          await firestore.collection(_postCollection).doc(post.id).get();

      final data = postDoc.data()!['likes'] as List;
      final likes = data.map((e) => e.toString()).toList();

      if (likes.contains(followId)) {
        await firestore.collection(_postCollection).doc(post.id).update({
          'likes': FieldValue.arrayRemove([followId])
        });
      } else {
        await firestore.collection(_postCollection).doc(post.id).update({
          'likes': FieldValue.arrayUnion([followId])
        });
      }
      return const Response(data: ResponseData.empty);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.toString());
    } catch (_) {
      throw const DatastoreException();
    }
  }

  @override
  Future<Response> uploadPost(Post post) async {
    try {
      /*String photoUrl = '';

      if (postFile != null) {
        final response =
            await storageService.uploadImageToStorage('posts', postFile, true);
        photoUrl = response.data;
      }

      Post newPost = post.copyWith(photoPostUrl: photoUrl);*/

      firestore.collection(_postCollection).doc(post.id).set(post.toJson());

      return const Response(data: ResponseData.empty);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }

  @override
  Future<Response> getAllPosts() async {
    try {
      QuerySnapshot postSnap =
          await firestore.collection(_postCollection).get();

      final posts = postSnap.docs
          .map(
            (post) => _convertToMap(
              post.data(),
            ),
          )
          .toList();

      return Response(data: posts);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }

  Map<String, dynamic> _convertToMap(data) {
    return {
      'id': data['id'],
      'description': data['description'],
      'datePublished': data['datePublished'].toDate(),
      'photoPostUrl': data['photoPostUrl'],
      'likes': data['likes'],
      'userId': data['userId'],
      'username': data['username'],
      'profileImage': data['profileImage'],
    };
  }

  @override
  Future<Response> getPostByUserId(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> postSnap = await firestore
          .collection(_postCollection)
          .where('userId', isEqualTo: userId)
          .get();

      final posts = postSnap.docs
          .map(
            (post) => _convertToMap(
              post.data(),
            ),
          )
          .toList();

      return Response(data: posts);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }

  @override
  Future<Response> getPostLikes(String postId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> postDoc =
          await firestore.collection(_postCollection).doc(postId).get();

      final likes = postDoc.data()!['likes'];

      return Response(data: likes);
    } on FirebaseException catch (e) {
      throw DatastoreException(code: e.code);
    } catch (_) {
      throw const DatastoreException();
    }
  }
}
