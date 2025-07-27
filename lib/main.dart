import 'package:flutter/material.dart';
import 'package:new_app/Features/auth/pages/sign_up.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          prefixIconColor: Colors.grey,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
      home: const SignUpScreen(),
      navigatorKey: appKey,
    );
  }
}
