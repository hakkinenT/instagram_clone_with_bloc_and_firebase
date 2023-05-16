import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../models/user.dart';
import '../../service/interfaces/file_storage_service.dart';
import '../../service/interfaces/user_service.dart';
import '../interfaces/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService userService;
  final FileStorageService storageService;

  const UserRepositoryImpl({
    required this.userService,
    required this.storageService,
  });

  @override
  Future<Either<Failure, Unit>> addUser(User user) async {
    try {
      await userService.addUser(user);

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
      final user = await userService.getUser(userId);
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
      String photoUrl = '';
      late User userUpdated;

      if (photoFile != null) {
        final response = await storageService.uploadImageToStorage(
            'profilePics', photoFile, false);
        photoUrl = response.data;

        userUpdated = user.copyWith(photoUrl: photoUrl);
      } else {
        userUpdated = user;
      }

      //! Falta atualizar no firebase

      await userService.updateUser(userUpdated);

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
      await userService.followUser(userId, followId);
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
