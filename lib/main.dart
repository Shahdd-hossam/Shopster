import 'package:flutter/material.dart';
import 'package:new_app/features/auth/signup_screen.dart';
import 'package:new_app/features/auth/login_screen.dart';
import 'package:new_app/features/Home/home_page.dart';
import 'package:new_app/features/cart/pages/cart_screen.dart';
import 'package:new_app/features/favourates/pages/favourates_screen.dart';
import 'package:new_app/features/profille/pages/profile_screen.dart';
import 'package:new_app/core/Theme/theme_manager.dart';
import 'package:new_app/core/Theme/app_theme.dart';
import 'package:new_app/core/di/injection_container.dart';
import 'package:new_app/core/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(const MyApp());
}

// to get current context from any where
final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();
BuildContext get appContext => appKey.currentContext!;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'New App',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          navigatorKey: appKey,
          home: FutureBuilder<bool>(
            future: sl<AuthService>().validateSession(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              
              if (snapshot.data == true) {
                return const HomePage();
              } else {
                return const LoginPage();
              }
            },
          ),
          routes: {
            '/home': (context) => const HomePage(),
            '/login': (context) => const LoginPage(),
            '/signup': (context) => const SignUpPage(),
            '/cart': (context) => const CartScreen(),
            '/favorites': (context) => const FavoritesScreen(),
            '/profile': (context) => const ProfileScreen(),
          },
        );
      },
    );
  }
}