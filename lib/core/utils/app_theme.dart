// lib/core/utils/app_theme.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      appBarTheme: const AppBarTheme(
        color: AppColors.blackAndWhiteLightMode,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.textColor),
      ),
      // Define other theme properties as needed
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      appBarTheme: const AppBarTheme(
        color: AppColors.blackAndWhiteDarkMode,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
      // Define other theme properties as needed
    );
  }
}
