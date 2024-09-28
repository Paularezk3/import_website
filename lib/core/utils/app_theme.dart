// lib/core/utils/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static TextTheme _textTheme(bool isDark, BuildContext context) {
    return TextTheme(
      displayLarge: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: AppColors.notBlackAndWhiteColor(context),
        ),
      ),
      displayMedium: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: AppColors.blackAndWhiteColor(context),
        ),
      ),
      titleLarge: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.notBlackAndWhiteColor(context),
        ),
      ),
      bodyLarge: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.notBlackAndWhiteColor(context),
        ),
      ),
      bodyMedium: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[850],
        ),
      ),
      bodySmall: GoogleFonts.openSans(
        textStyle: TextStyle(
          color: Colors.grey[700],
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
        color: AppColors.blackAndWhiteColor(context),
        elevation: 0,
      ),
      textTheme: _textTheme(true, context),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
        color: AppColors.blackAndWhiteColor(context),
        elevation: 0,
      ),
      textTheme: _textTheme(false, context),
    );
  }
}
