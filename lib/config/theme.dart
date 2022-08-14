import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      primary: Color(0xFFFE3C5B),
      secondary: Color(0xFFE84545),
      background: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      error: Color(0xFF000000),
      brightness: Brightness.light,
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onError: Color(0xFF2B2E4A),
      onBackground: Color(0xFF2B2E4A),
      onSurface: Color(0xFF2B2E4A),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFF1B070B),
        fontWeight: FontWeight.bold,
        fontSize: 36,
        letterSpacing: .5,
      ),
      headline2: TextStyle(
        color: Color(0xFF1B070B),
        fontWeight: FontWeight.bold,
        fontSize: 24,
        letterSpacing: .5,
      ),
      headline3: TextStyle(
        color: Color(0xFF1B070B),
        fontWeight: FontWeight.bold,
        fontSize: 18,
        letterSpacing: .5,
      ),
      headline4: TextStyle(
        color: Color(0xFF1B070B),
        fontWeight: FontWeight.bold,
        fontSize: 16,
        letterSpacing: .5,
      ),
      headline5: TextStyle(
        color: Color(0xFF1B070B),
        fontWeight: FontWeight.bold,
        fontSize: 14,
        letterSpacing: .5,
      ),
      headline6: TextStyle(
        color: Color(0xFF1B070B),
        fontWeight: FontWeight.normal,
        fontSize: 14,
        letterSpacing: .5,
      ),
      bodyText1: TextStyle(
        color: Color(0xFF1B070B),
        fontWeight: FontWeight.normal,
        fontSize: 12,
        letterSpacing: .5,
      ),
      bodyText2: TextStyle(
        color: Color(0xFF1B070B),
        fontWeight: FontWeight.normal,
        fontSize: 10,
        letterSpacing: .5,
      ),
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      // titleSpacing: 0,
    ),
  );
}