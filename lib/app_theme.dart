import 'package:flutter/material.dart';

void primaryColorDefiner(bool lightTheme) {
  if (lightTheme) {
    primaryColor = primaryColorLight;
  } else {
    primaryColor = primaryColorDark;
  }
}

// Main Colors
Color primaryColor = const Color(0xff009688);

// Night Colors
const Color primaryColorDark = Color(0xff1e1433);
const Color secondaryColorNight = Color(0xff262331);

// Day Colors
const Color primaryColorLight = Color(0xff009688);
const Color secondaryColorDay = Color(0xff5cd4ce);

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: todoTextTheme,
);

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
