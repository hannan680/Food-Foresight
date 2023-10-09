import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(225, 91, 30, 1);
final ThemeData appTheme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color.fromRGBO(253, 247, 245, 1),
    colorScheme: const ColorScheme.light().copyWith(secondary: primaryColor),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      prefixIconColor: Colors.grey,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: primaryColor.withOpacity(.3),
        elevation: 0,
        foregroundColor: Colors.black.withOpacity(.5)));
