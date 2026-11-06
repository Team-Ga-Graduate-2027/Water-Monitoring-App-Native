import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFF151515);
  static const header = Color(0xFF101111);
  static const surface = Color(0xFF2C3333);
  static const surfaceRaised = Color(0xFF252C2C);
  static const muted = Color(0xFFB2B2B2);
  static const accent = Color(0xFF76CE98);
  static const warning = Color(0xFFFFB84D);
  static const danger = Color(0xFFFF1B1B);
}

abstract final class AppTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.dark,
      surface: AppColors.surface,
      primary: AppColors.accent,
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
