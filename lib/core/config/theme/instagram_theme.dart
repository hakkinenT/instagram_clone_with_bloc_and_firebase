import 'package:flutter/material.dart';

class InstagramTheme {
  static final light = themeLight.copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme.copyWith(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );
  static final appBarTheme = themeLight.appBarTheme;
  static final themeLight = ThemeData.light();
}
