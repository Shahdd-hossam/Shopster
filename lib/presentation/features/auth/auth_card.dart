import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget leftChild;
  final Widget rightChild;

  const AuthCard({super.key, required this.leftChild, required this.rightChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(blurRadius: 12, color: Colors.black12),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: leftChild),
          Expanded(child: rightChild),
        ],
      ),
    );
  }
}
