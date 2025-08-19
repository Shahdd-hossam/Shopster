import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';
import 'package:new_app/features/cart/pages/cart_screen.dart';
import 'package:new_app/features/favourates/pages/favourates_screen.dart';
import 'package:new_app/features/profille/pages/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const BottomNavBar({
    super.key,
    this.currentIndex = 0,
    this.onTap, required Future<Object?> Function() onHomePressed, required Future<Object?> Function() onCartPressed, required Future<Object?> Function() onProfilePressed,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Home - stay on current page
        break;
      case 1:
        // Navigate to Cart
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartScreen()),
        );
        break;
      case 2:
        // Navigate to Favorites
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavoritesScreen()),
        );
        break;
      case 3:
        // Navigate to Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }

    // Call the optional callback
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
