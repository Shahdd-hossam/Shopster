import 'package:flutter/material.dart';
import 'package:new_app/Features/Home/home_widgets/category_cards.dart';
import 'package:new_app/Features/Home/home_widgets/features_cards.dart';
import 'package:new_app/Features/widgets/app_search_bar.dart';
import 'package:new_app/core/managers/alerts_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
      title: const Text("Welcome Back"),
      backgroundColor: Colors.teal,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            AlertManager.showLogoutDialog(context);
          },
        ),
      ],
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
                  CategoryCard(title: "Study", icon: Icons.book),
                  CategoryCard(title: "Work", icon: Icons.work),
                  CategoryCard(title: "Fun", icon: Icons.emoji_emotions),
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
                  FeatureCard(title: "AI Assistant", icon: Icons.smart_toy, color: Colors.teal),
                  FeatureCard(title: "Resume Tips", icon: Icons.description, color: Colors.orange),
                  FeatureCard(title: "Mock Interview", icon: Icons.mic, color: Colors.purple),
                  FeatureCard(title: "Job Market", icon: Icons.show_chart, color: Colors.indigo),
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
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}





