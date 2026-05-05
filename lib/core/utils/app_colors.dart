import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Color background = Color(0xFFE6EDF5);
  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color secondaryColor = Color(0xFF0EA5E9); // Sky Blue
  static const Color amberAccent = Color(0xFFF59E0B);
  static const Color textPrimary = Color(0xFF1E293B); // Dark Slate (للعناوين)
  static const Color textSecondary = Color(0xFF64748B);

  static const Color white = Colors.white;

  static const Color inactiveDot = Color(0xFFCBD5E1);
  static const Color containerShadow = Color(0x1A000000);
  static const Color inputBackground = Color(0xFFF1F5F9); // Very Light Grey
  static const Color accentBlue = Color(0xFF0EA5E9); // Accent Blue
  static const Color grey = Colors.grey;
  static const Color redColor = Colors.red;
  static const activeColor = Color(0xFF4F46E5);
  static const activeBgColor = Color(0xFFE6EDF5);
  static const inactiveColor = Color(0xFF424242);
  static const transparent = Colors.transparent;

  //

  static const Color primaryContainer = Color(0xFF4F46E5);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF141B2B);
  static const Color onSurfaceVariant = Color(0xFF464555);
  static const Color outlineVariant = Color(0xFFC7C4D8);
  static const Color amber = Color(0xFFF59E0B);
  static const Color surfaceContainerLow = Color(0xFFF1F3FF);
  static const Color primaryLight = Color(0xFFDAD7FF);
  //

  static const Color outline = Color(0xFF777587);
  static const Color tertiaryFixed = Color(0xFFFFDBCC);
  static const Color onTertiaryFixed = Color(0xFF351000);
  static const Color secondaryContainer = Color(0xFF39B8FD);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, primaryContainer],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
  static const cardPurple = Color(0xffEEF2FF);
  static const cardBlue = Color(0xffF0F9FF);
  static const cardMint = Color(0xffECFDF5);

  static const shadow = Color(0x14000000);
  static const border = Colors.black;
}
