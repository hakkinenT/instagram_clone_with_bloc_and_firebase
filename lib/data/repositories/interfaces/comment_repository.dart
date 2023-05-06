import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../models/comment.dart';

abstract class CommentRepository {
  Future<Either<Failure, Unit>> createComment(Comment comment);
  Future<Either<Failure, List<Comment>>> getCommentsByPost(Comment comment);
}
