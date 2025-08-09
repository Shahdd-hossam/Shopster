import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Chip(
            label: Text(title),
            avatar: Icon(
              icon, 
              size: 20, 
              color: isSelected ? Colors.white : Colors.teal,
            ),
            backgroundColor: isSelected ? Colors.teal : Colors.teal.withOpacity(0.1),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.teal,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            side: BorderSide(
              color: Colors.teal,
              width: isSelected ? 0 : 1,
            ),
          ),
        ),
      ),
    );
  }
}
