import 'package:dartz/dartz.dart';

import '../../models/user.dart';
import '../interfaces/authentication_repository.dart';
import '../../service/interfaces/auth_service.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthService service;

  const AuthenticationRepositoryImp({required this.service});

  @override
  Stream<User> get user => service.user.data;

  @override
  User get currentUser {
    return service.currentUser.data;
  }

  @override
  Future<Either<Failure, Unit>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await service.logInWithEmailAndPassword(email: email, password: password);
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
      await service.logInWithGoogle();
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
      await service.logOut();
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
      await service.signUp(
          username: username, email: email, password: password);
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
