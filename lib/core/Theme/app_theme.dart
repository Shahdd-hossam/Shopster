import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';

class AppThemes {
  static final lightTheme = _generalTheme(isDark: false);

  static final darkTheme = _generalTheme(isDark: true);

  static ThemeData _generalTheme({required bool isDark}) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: isDark ? AppColors.black : AppColors.greyLight,
      primaryColor: AppColors.primary,

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.greyLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintStyle: TextStyle(fontSize: 14, color: isDark ? AppColors.greyLight : AppColors.grey, fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: isDark ? AppColors.greyLight : AppColors.grey), borderRadius: BorderRadius.circular(8)),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: isDark ? AppColors.greyLight.withAlpha(50) : AppColors.grey.withAlpha(50)), borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColors.greyLight), borderRadius: BorderRadius.circular(8)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: AppColors.red)),
        suffixIconColor: AppColors.grey,
        prefixIconColor: AppColors.grey,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
        //
        ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.greyLight),
          //
          foregroundColor: WidgetStateProperty.all(AppColors.black),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              //
            ),
          ),
          textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}