import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';

class RoundIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const RoundIcon({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconButton(
        icon: Icon(
          icon, 
          size: 18, 
          color: AppColors.textLight,
        ),
        onPressed: onPressed ?? () {},
      ),
    );
  }
}
