import 'package:school_management/core/error/exceptions.dart';
import 'package:school_management/data/models/comment.dart';
import 'package:school_management/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:school_management/data/repositories/interfaces/comment_repository.dart';
import 'package:school_management/data/service/interfaces/comment_service.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentService service;

  const CommentRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, Unit>> createComment(Comment comment) async {
    try {
      await service.createComment(comment);
      return const Right(unit);
    } on DatastoreException catch (e) {
      return Left(
        DatastoreFailure.fromCode(e.code),
      );
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getCommentsByPost(
      Comment comment) async {
    try {
      final response = await service.getCommentsByPost(comment);
      final List<Map<String, dynamic>> responseList = response.data;

      final comments =
          responseList.map((comment) => Comment.fromJson(comment)).toList();

      return Right(comments);
    } on DatastoreException catch (e) {
      return Left(DatastoreFailure.fromCode(e.code));
    }
  }
}
