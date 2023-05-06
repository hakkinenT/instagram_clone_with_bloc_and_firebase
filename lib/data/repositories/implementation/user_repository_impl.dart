import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../models/user.dart';
import '../../service/interfaces/user_service.dart';
import '../interfaces/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService service;

  const UserRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, Unit>> addUser(User user) async {
    try {
      await service.addUser(user);
      return const Right(unit);
    } on DatastoreException catch (e) {
      return Left(
        DatastoreFailure.fromCode(e.code),
      );
    }
  }

  @override
  Future<Either<Failure, User>> getUser(String userId) async {
    try {
      final user = await service.getUser(userId);
      return Right(
        User.fromJson(user.data),
      );
    } on DatastoreException catch (e) {
      return Left(
        DatastoreFailure.fromCode(
          e.code,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(User user,
      [Uint8List? photoFile]) async {
    try {
      await service.updateUser(user, photoFile);
      return const Right(unit);
    } on DatastoreException catch (e) {
      return Left(
        DatastoreFailure.fromCode(
          e.code,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> followUser(
      String userId, String followId) async {
    try {
      await service.followUser(userId, followId);
      return const Right(unit);
    } on DatastoreException catch (e) {
      return Left(
        DatastoreFailure.fromCode(
          e.code,
        ),
      );
    }
  }
}
