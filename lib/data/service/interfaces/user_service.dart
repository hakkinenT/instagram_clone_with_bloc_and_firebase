import 'package:flutter/foundation.dart';
import 'package:school_management/data/models/user.dart';

import '../response/response.dart';

abstract class UserService {
  Future<Response> addUser(User user);
  Future<Response> getUser(String id);
  Future<Response> updateUser(User user, [Uint8List? photoFile]);
  Future<Response> followUser(String userId, String followId);
}
