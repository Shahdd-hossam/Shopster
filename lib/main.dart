import 'package:flutter/material.dart';
import 'package:new_task/core/Themes/app_theme.dart';
import 'package:new_task/core/Themes/theme_manager.dart';
import 'package:new_task/presentation/features/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

// Global navigator key for navigation outside of widget context
final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();

// Safe context getter with null check
BuildContext? get appContext => appKey.currentContext;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder <ThemeMode>(valueListenable:ThemeManager.themeNotifier, 
    builder: (context, currentTheme , child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: currentTheme, 
        home: const SplashScreen(),
        navigatorKey: appKey,
      );
    });
  }
}