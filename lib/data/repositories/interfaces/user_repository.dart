import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:school_management/data/models/user.dart';

import '../../../core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> addUser(User user);
  Future<Either<Failure, User>> getUser(String userId);
  Future<Either<Failure, Unit>> updateUser(User user, [Uint8List? photoFile]);
  Future<Either<Failure, Unit>> followUser(String userId, String followId);
}
