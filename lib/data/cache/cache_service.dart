import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserCacheService {
  final SharedPreferences sharedPreferences;

  const UserCacheService({required this.sharedPreferences});

  void write(String key, User user) async {
    await sharedPreferences.setString(
      key,
      json.encode(
        user.toJson(),
      ),
    );
  }

  User? read(String key) {
    final response = sharedPreferences.getString(key);
    if (response != null) {
      return User.fromJson(json.decode(response));
    }

    return null;
  }
}
