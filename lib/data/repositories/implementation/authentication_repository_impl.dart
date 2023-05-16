import 'package:dartz/dartz.dart';

import '../../models/user.dart';
import '../../service/interfaces/user_service.dart';
import '../interfaces/authentication_repository.dart';
import '../../service/interfaces/auth_service.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthService authService;
  final UserService userService;

  const AuthenticationRepositoryImp({
    required this.authService,
    required this.userService,
  });

  @override
  Stream<User> get user => authService.user.data;

  @override
  User get currentUser {
    return authService.currentUser.data;
  }

  @override
  Future<Either<Failure, Unit>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await authService.logInWithEmailAndPassword(
          email: email, password: password);
      return const Right(unit);
    } on AuthenticationException catch (e) {
      return Left(
        AuthenticationFailure.fromCode(
          e.code,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> logInWithGoogle() async {
    try {
      await authService.logInWithGoogle();
      return const Right(unit);
    } on AuthenticationException catch (e) {
      return Left(
        AuthenticationFailure.fromCode(
          e.code,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      await authService.logOut();
      return const Right(unit);
    } on AuthenticationException catch (e) {
      return Left(
        AuthenticationFailure.fromCode(
          e.code,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final response = await authService.signUp(
          username: username, email: email, password: password);

      final id = response.data.toString();

      User user = User(
        id: id,
        email: email,
        username: username,
      );

      await userService.addUser(user);
      return const Right(unit);
    } on AuthenticationException catch (e) {
      return Left(
        AuthenticationFailure.fromCode(
          e.code,
        ),
      );
    }
  }
}
