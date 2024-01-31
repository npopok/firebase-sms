import 'package:flutter/material.dart';

abstract class Styles {
  static ThemeData theme() => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F6F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F6F6),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFE3E3E3),
          selectedItemColor: Color(0xFF0098EE),
          elevation: 0,
        ),
        textTheme: const TextTheme(
          labelMedium: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF7D7D7D),
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF7D7D7D),
          ),
          headlineMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF4D4D4D),
          ),
          headlineLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xFF4D4D4D),
          ),
        ),
        cardTheme: const CardTheme(
          color: Color(0xFFFDFDFD),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFDFDFD),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide.none,
          ),
        ),
      );
}
