import 'package:school_management/data/models/post.dart';
import 'package:school_management/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'dart:typed_data';

import 'package:school_management/data/repositories/interfaces/post_repository.dart';
import 'package:school_management/data/service/interfaces/post_service.dart';

import '../../../core/error/exceptions.dart';

class PostRepositoryImpl implements PostRepository {
  final PostService service;

  const PostRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    try {
      await service.deletePost(postId);
      return const Right(unit);
    } on DatastoreException catch (e) {
      return Left(
        DatastoreFailure.fromCode(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> likePost(Post post, String followId) async {
    try {
      await service.likePost(post, followId);
      return const Right(unit);
    } on DatastoreException catch (e) {
      return Left(
        DatastoreFailure.fromCode(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadPost(Post post,
      [Uint8List? postFile]) async {
    try {
      await service.uploadPost(post, postFile);
      return const Right(unit);
    } on DatastoreFailure catch (e) {
      return Left(
        DatastoreFailure.fromCode(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    try {
      final response = await service.getAllPosts();
      List<Map<String, dynamic>> responseList = response.data;

      final posts = responseList.map((post) => Post.fromJson(post)).toList();

      return Right(posts);
    } on DatastoreException catch (e) {
      return Left(DatastoreFailure.fromCode(e.code));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPostByUserId(String userId) async {
    try {
      final response = await service.getPostByUserId(userId);
      List<Map<String, dynamic>> responseList = response.data;

      final posts = responseList.map((post) => Post.fromJson(post)).toList();

      return Right(posts);
    } on DatastoreException catch (e) {
      return Left(DatastoreFailure.fromCode(e.code));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPostLikes(String postId) async {
    try {
      final response = await service.getPostLikes(postId);
      List<dynamic> responseList = response.data;

      final likes = responseList.map((userId) => userId.toString()).toList();

      return Right(likes);
    } on DatastoreException catch (e) {
      return Left(DatastoreFailure.fromCode(e.code));
    }
  }
}
