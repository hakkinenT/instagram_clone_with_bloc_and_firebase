import 'package:dartz/dartz.dart';
import 'package:school_management/data/models/user.dart';

import '../../../core/error/failure.dart';

abstract class AuthenticationRepository {
  Stream<User> get user;
  User get currentUser;
  Future<Either<Failure, Unit>> signUp(
      {required String username,
      required String email,
      required String password});
  Future<Either<Failure, Unit>> logInWithGoogle();
  Future<Either<Failure, Unit>> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<Either<Failure, Unit>> logOut();
}
