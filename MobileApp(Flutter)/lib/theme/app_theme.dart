import 'package:flutter/material.dart';

abstract final class AppColors {
  static bool get _isDark => AppTheme.themeMode.value == ThemeMode.dark;

  static Color get background =>
      _isDark ? const Color(0xFF151515) : const Color(0xFFE1E8E3);
  static Color get header =>
      _isDark ? const Color(0xFF101111) : const Color(0xFFD5DFD8);
  static Color get headerBorder =>
      _isDark ? const Color(0xFF3B3B3B) : const Color(0xFFBCC9C0);
  static Color get surface =>
      _isDark ? const Color(0xFF2C3333) : const Color(0xFFEAF0EC);
  static Color get surfaceRaised =>
      _isDark ? const Color(0xFF252C2C) : const Color(0xFFCFDAD2);
  static Color get foreground =>
      _isDark ? const Color(0xFFFFFFFF) : const Color(0xFF18231C);
  static Color get muted =>
      _isDark ? const Color(0xFFB2B2B2) : const Color(0xFF58675E);
  static const accent = Color(0xFF76CE98);
  static const warning = Color(0xFFFFB84D);
  static const danger = Color(0xFFFF1B1B);
}

abstract final class AppTheme {
  static final themeMode = ValueNotifier(ThemeMode.dark);
  static final notificationsEnabled = ValueNotifier(true);

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF151515),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.dark,
      surface: const Color(0xFF2C3333),
      primary: AppColors.accent,
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF151515),
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

  static ThemeData get light {
    const background = Color(0xFFE1E8E3);
    const surface = Color(0xFFEAF0EC);
    const foreground = Color(0xFF18231C);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.light,
        surface: surface,
        primary: AppColors.accent,
        onSurface: foreground,
      ),
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: foreground,
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
