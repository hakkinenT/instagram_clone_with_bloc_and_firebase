import 'package:dartz/dartz.dart';
import 'dart:typed_data';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../models/post.dart';
import '../../service/interfaces/file_storage_service.dart';
import '../../service/interfaces/post_service.dart';
import '../interfaces/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostService postService;
  final FileStorageService storageService;

  const PostRepositoryImpl({
    required this.postService,
    required this.storageService,
  });

  @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    try {
      await postService.deletePost(postId);
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
      await postService.likePost(post, followId);
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
      String photoUrl = '';

      if (postFile != null) {
        final response =
            await storageService.uploadImageToStorage('posts', postFile, true);
        photoUrl = response.data;
      }

      Post newPost = post.copyWith(photoPostUrl: photoUrl);

      await postService.uploadPost(newPost);
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
      final response = await postService.getAllPosts();
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
      final response = await postService.getPostByUserId(userId);
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
      final response = await postService.getPostLikes(postId);
      List<dynamic> responseList = response.data;

      final likes = responseList.map((userId) => userId.toString()).toList();

      return Right(likes);
    } on DatastoreException catch (e) {
      return Left(DatastoreFailure.fromCode(e.code));
    }
  }
}
