import '../../models/user.dart';
import '../response/response.dart';

abstract class UserService {
  Future<Response> addUser(User user);
  Future<Response> getUser(String id);
  Future<Response> updateUser(User user);
  Future<Response> followUser(String userId, String followId);
}
