import '../../models/comment.dart';
import '../response/response.dart';

abstract class CommentService {
  Future<Response> createComment(Comment comment);
  Future<Response> getCommentsByPost(Comment comment);
}
