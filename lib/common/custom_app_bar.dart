import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';
import 'package:new_app/core/Theme/theme_manager.dart';
import 'package:new_app/features/auth/signup_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Logout icon
              IconButton(
                icon: const Icon(Icons.logout, color: AppColors.black),
                onPressed: () => _showLogoutDialog(context),
              ),

              // Right side - Theme toggle and Cart icons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Theme toggle icon
                  ValueListenableBuilder<ThemeMode>(
                    valueListenable: ThemeManager.themeNotifier,
                    builder: (context, themeMode, child) {
                      return IconButton(
                        icon: Icon(
                          themeMode == ThemeMode.light 
                              ? Icons.wb_sunny 
                              : Icons.nightlight_round,
                        ),
                        onPressed: () {
                          ThemeManager.toggleTheme();
                        },
                      );
                    },
                  ),
                  
                  // Cart icon
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                       // Navigate to cart page
                       Navigator.pushNamed(context, '/cart');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to leave the page?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Navigate to signup screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
              child: const Text('Yes', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
