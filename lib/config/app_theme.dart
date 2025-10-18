import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.aquaBlue,
      tertiary: AppColors.brightYellow,
      error: AppColors.accentRed,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
      elevation: 3,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.aquaBlue,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge:
          TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: AppColors.textDark),
      bodySmall: TextStyle(color: AppColors.charcoalGray),
    ),
    cardColor: Colors.white,
    iconTheme: const IconThemeData(color: AppColors.secondaryBlue),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.secondaryBlue,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.secondaryBlue,
      secondary: AppColors.aquaBlue,
      tertiary: AppColors.brightYellow,
      error: AppColors.accentRed,
      surface: AppColors.charcoalGray,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.secondaryBlue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.brightYellow,
      foregroundColor: Colors.black,
    ),
    textTheme: const TextTheme(
      headlineLarge:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white54),
    ),
    iconTheme: const IconThemeData(color: AppColors.aquaBlue),
  );
}
