import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Primary & Accent
  static const Color primaryColor = Color(
    0xFF08431D,
  ); // Primary Deep Emerald Green
  static const Color primaryLight = Color(0xFF1E6B37); // Lighter Emerald
  static const Color primaryDark = Color(0xFF04240F); // Darker Emerald
  static const Color secondaryColor = Color(0xFF2E7D32); // Vibrant Accent Green
  static const Color amberAccent = Color(0xFFFFA726); // Warm Amber Accent

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF6F8F6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFE8F1EA);
  static const Color lightTextPrimary = Color(0xFF0F1C12);
  static const Color lightTextSecondary = Color(0xFF556B5C);
  static const Color lightTextMuted = Color(0xFF94A89A);
  static const Color lightBorder = Color(0xFFE0E8E2);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0B140D);
  static const Color darkSurface = Color(0xFF132216);
  static const Color darkSurfaceVariant = Color(0xFF1B2E20);
  static const Color darkTextPrimary = Color(0xFFF0F5F1);
  static const Color darkTextSecondary = Color(0xFFA1B8A7);
  static const Color darkTextMuted = Color(0xFF6B8272);
  static const Color darkBorder = Color(0xFF1F3825);

  // Functional / Status Colors
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF0288D1);

  // Common Constants
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}
