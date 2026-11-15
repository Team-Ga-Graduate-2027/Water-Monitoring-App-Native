import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SalinSuriApp());
}

class SalinSuriApp extends StatelessWidget {
  const SalinSuriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppTheme.themeMode,
      builder: (context, themeMode, _) {
        final isDark = themeMode == ThemeMode.dark;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: AppColors.header,
            statusBarIconBrightness: isDark
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: AppColors.background,
            systemNavigationBarIconBrightness: isDark
                ? Brightness.light
                : Brightness.dark,
          ),
        );
        return MaterialApp(
          title: 'Salin-Suri',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
