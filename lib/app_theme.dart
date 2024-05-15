import 'package:flutter/material.dart';

// Night Colors
const Color darkModePrimaryDark = Color(0xff0e051a);
const Color darkModePrimary = Color(0xff1e1433);
const Color darkModePrimaryLight = Color(0xff262331);

// Day Colors
Color lightModePrimaryDark = Colors.teal.shade700;
Color lightModePrimary = Colors.teal;
Color lightModePrimaryLight = Colors.teal.shade200;

TextTheme todoTextTheme = const TextTheme(
  displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  displayMedium: TextStyle(fontSize: 60.0, fontStyle: FontStyle.italic),
  displaySmall: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400),
  headlineMedium: TextStyle(
    fontSize: 36.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  headlineSmall: TextStyle(
    fontSize: 24.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  titleLarge: TextStyle(
    fontSize: 22.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  ),
  titleMedium: TextStyle(
    fontSize: 20.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  ),
  titleSmall: TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  ),
  bodyLarge: TextStyle(
    fontSize: 16.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: TextStyle(
    fontSize: 14.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: TextStyle(
    fontSize: 12.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  ),
);
