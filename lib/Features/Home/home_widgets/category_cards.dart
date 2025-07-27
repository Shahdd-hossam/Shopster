import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Chip(
        label: Text(title),
        avatar: Icon(icon, size: 20, color: Colors.white),
        backgroundColor: Colors.teal,
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
