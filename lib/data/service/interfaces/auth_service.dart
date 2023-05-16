import '../response/response.dart';

abstract class AuthService {
  Response get user;
  Response get currentUser;
  Future<Response> signUp({
    required String username,
    required String email,
    required String password,
  });
  Future<Response> logInWithGoogle();
  Future<Response> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Response> logOut();
}
