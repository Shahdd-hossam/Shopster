import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';

class PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: bold ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
              color: bold ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
