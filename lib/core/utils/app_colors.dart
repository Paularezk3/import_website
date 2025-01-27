// lib/core/utils/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF000000);
  static const Color differentColor1 = Color.fromARGB(255, 140, 157, 255);
  static const Color differentColor2 = Color.fromARGB(255, 134, 255, 138);
  static const Color differentColor3 = Color.fromARGB(255, 255, 133, 146);
  static const Color differentColor4 = Color.fromARGB(255, 255, 199, 115);

  static const Color blackAndWhiteDarkMode = Color.fromARGB(255, 0, 0, 0);
  static Color backgroundSecondaryColorDarkMode = Colors.grey[850]!;
  static const Color shimmerBaseColorDarkMode =
      Color.fromARGB(255, 19, 19, 19);
  static const Color shimmerHighlightColorDarkMode =
      Color.fromARGB(255, 56, 56, 56);

  static const Color blackAndWhiteLightMode =
      Color.fromARGB(255, 255, 255, 255);
  static Color backgroundSecondaryColorLightMode = Colors.blue[50]!;
  static const Color shimmerBaseColorLightMode =
      Color.fromARGB(255, 224, 224, 224);
  static const Color shimmerHighlightColorLightMode =
      Color.fromARGB(255, 245, 245, 245);

  static Color blackAndWhiteColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? blackAndWhiteDarkMode
          : blackAndWhiteLightMode;
  static Color notBlackAndWhiteColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? blackAndWhiteLightMode
          : blackAndWhiteDarkMode;
  static Color backgroundSecondaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? backgroundSecondaryColorDarkMode
          : backgroundSecondaryColorLightMode;
  static Color shimmerBaseColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? shimmerBaseColorDarkMode
          : shimmerBaseColorLightMode;
  static Color shimmerHighlightColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? shimmerHighlightColorDarkMode
          : shimmerHighlightColorLightMode;

  static List<BoxShadow> iconsShadowsDarkMode = const [
    BoxShadow(
      color: Color(0x99161616),
      blurRadius: 40,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> iconsShadowsLightMode = const [
    BoxShadow(
      color: Color.fromARGB(255, 255, 255, 255),
      blurRadius: 50,
      offset: Offset(0, 6),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> iconsShadows(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? iconsShadowsDarkMode
          : iconsShadowsLightMode;
}
