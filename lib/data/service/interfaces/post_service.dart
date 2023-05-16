import '../../models/post.dart';
import '../response/response.dart';

abstract class PostService {
  Future<Response> uploadPost(Post post);
  Future<Response> likePost(Post post, String followId);
  Future<Response> deletePost(String postId);
  Future<Response> getPostByUserId(String userId);
  Future<Response> getPostLikes(String postId);
  Future<Response> getAllPosts();
}
