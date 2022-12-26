import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Colors.grey,
    ),
    textTheme: const TextTheme(
      bodyText2: TextStyle(
        wordSpacing: 1.5,
        fontSize: 16,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[100],
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        gapPadding: 0.0,
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );

  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: const IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Colors.grey,
    ),
    textTheme: const TextTheme(
      bodyText2: TextStyle(
        wordSpacing: 1.5,
        fontSize: 16,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[800],
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        gapPadding: 0.0,
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );

  bool isLight = true;

  void changeTheme() {
    isLight = !isLight;
    notifyListeners();
  }
}
