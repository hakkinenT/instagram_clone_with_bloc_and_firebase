import 'package:school_management/data/models/comment.dart';
import 'package:school_management/data/service/response/response.dart';

abstract class CommentService {
  Future<Response> createComment(Comment comment);
  Future<Response> getCommentsByPost(Comment comment);
}
