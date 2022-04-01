import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkThemeData = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey,
    canvasColor: Colors.grey.shade700,
    backgroundColor: Colors.blueGrey,
    accentColor: Colors.yellow,
  );
  static ThemeData lightThemeData = ThemeData.light().copyWith(
    primaryColor: Colors.grey,
    canvasColor: Colors.white38,
    backgroundColor: Colors.blueGrey,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.lightBlueAccent,
    ),
  );
}
