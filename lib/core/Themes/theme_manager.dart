import 'package:flutter/material.dart';
import 'package:new_task/presentation/features/widgets/app_colors.dart';

class AppThemes {
  static final lightTheme = _generalTheme(isDark: false);
  static final darkTheme = _generalTheme(isDark: true);

  static ThemeData _generalTheme({required bool isDark}) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: isDark ? AppColors.black : AppColors.white,
      primaryColor: isDark ? Colors.teal[300] : AppColors.teal,

      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? Colors.teal[700] : AppColors.teal,
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),


      // buttons colors
        elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              isDark ? Colors.teal[300] : Colors.teal),
          foregroundColor: WidgetStateProperty.all(
              isDark ? Colors.black : Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),

      // Textfields colors
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIconColor: isDark ? Colors.teal[200] : Colors.grey,
        hintStyle: TextStyle(
          color: isDark ? Colors.teal[100] : Colors.grey,
        ),
      ),

      // Text colors
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),
        bodyMedium: TextStyle(
          color: isDark ? Colors.white70 : Colors.black87,
        ),
        titleLarge: TextStyle(
          color: isDark ? Colors.teal[100] : Colors.teal[900],
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),

      // Icons colors
      iconTheme: IconThemeData(
        color: isDark ? Colors.teal[200] : Colors.teal,
      ),
    );
  }
}

