import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:school_management/core/error/failure.dart';
import 'package:school_management/data/models/post.dart';

abstract class PostRepository {
  Future<Either<Failure, Unit>> uploadPost(Post post, [Uint8List? postFile]);
  Future<Either<Failure, Unit>> likePost(Post post, String followId);
  Future<Either<Failure, Unit>> deletePost(String postId);
  Future<Either<Failure, List<Post>>> getPostByUserId(String userId);
  Future<Either<Failure, List<String>>> getPostLikes(String postId);
  Future<Either<Failure, List<Post>>> getAllPosts();
}
