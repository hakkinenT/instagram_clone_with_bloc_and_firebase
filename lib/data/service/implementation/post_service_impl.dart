import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:school_management/core/error/exceptions.dart';
import 'package:school_management/data/enum/response_data.dart';
import 'package:school_management/data/models/post.dart';
import 'package:school_management/data/service/interfaces/file_storage_service.dart';

import 'package:school_management/data/service/interfaces/post_service.dart';
import 'package:school_management/data/service/response/response.dart';

class PostServiceImpl implements PostService {
  final FirebaseFirestore firestore;
  final FileStorageService storageService;

  const PostServiceImpl(
      {required this.firestore, required this.storageService});

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
      if (post.likes.contains(followId)) {
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
  Future<Response> uploadPost(Post post, [Uint8List? postFile]) async {
    try {
      String photoUrl = '';

      if (postFile != null) {
        final response =
            await storageService.uploadImageToStorage('posts', postFile, true);
        photoUrl = response.data;
      }

      Post newPost = post.copyWith(photoPostUrl: photoUrl);

      firestore
          .collection(_postCollection)
          .doc(newPost.id)
          .set(newPost.toJson());

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
}
