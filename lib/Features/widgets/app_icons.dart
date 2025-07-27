 import 'package:flutter/material.dart';

Widget icons(IconData icon) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Icon(icon, size: 24),
    ),
  );
}