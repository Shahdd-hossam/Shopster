import 'package:flutter/material.dart';
import 'package:new_app/Features/auth/pages/sign_up.dart';
import 'package:new_app/Theme/app_theme.dart';
import 'package:new_app/Theme/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

// to get current context from any where
final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();
BuildContext get appContext => appKey.currentContext!;

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
        home: const SignUpScreen(),
        navigatorKey: appKey,
      );
    });
  }
}
