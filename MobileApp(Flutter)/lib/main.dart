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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.header,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      title: 'Salin-Suri',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const SplashScreen(),
    );
  }
}
