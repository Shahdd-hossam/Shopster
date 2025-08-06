import 'package:flutter/material.dart';
import 'package:new_app/Features/Home/home_widgets/category_cards.dart';
import 'package:new_app/Features/Home/home_widgets/features_cards.dart';
import 'package:new_app/Features/widgets/app_searchbar.dart';
import 'package:new_app/Features/widgets/app_topbar.dart';
import 'package:new_app/Theme/theme_manager.dart';
import 'package:new_app/core/managers/alerts_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onToggleTheme: ThemeManager.toggleTheme,
      ),
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                AlertManager.showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello, Friend",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "What would you like to do today?",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const AppSearchBar(),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryCard(title: "products", icon: Icons.restaurant_rounded),
                  CategoryCard(title: "offers", icon: Icons.discount),
                  CategoryCard(title: "new", icon: Icons.fiber_new_rounded),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: const [
                  FeatureCard(title: "Product1", icon: Icons.add_photo_alternate_outlined, color: Colors.teal),
                  FeatureCard(title: "Product2", icon: Icons.add_photo_alternate_outlined, color: Colors.orange),
                  FeatureCard(title: "Product3", icon: Icons.add_photo_alternate_outlined, color: Colors.purple),
                  FeatureCard(title: "Product4", icon: Icons.add_photo_alternate_outlined, color: Colors.indigo),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits_sharp), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
