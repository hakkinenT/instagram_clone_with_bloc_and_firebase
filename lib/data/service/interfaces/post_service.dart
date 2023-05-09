import 'package:flutter/foundation.dart';
import 'package:school_management/data/models/post.dart';
import 'package:school_management/data/service/response/response.dart';

abstract class PostService {
  Future<Response> uploadPost(Post post, [Uint8List? postFile]);
  Future<Response> likePost(Post post, String followId);
  Future<Response> deletePost(String postId);
  Future<Response> getPostByUserId(String userId);
  Future<Response> getAllPosts();
}
