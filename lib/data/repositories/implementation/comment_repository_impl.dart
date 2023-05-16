import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../models/comment.dart';
import '../../service/interfaces/comment_service.dart';
import '../interfaces/comment_repository.dart';

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
