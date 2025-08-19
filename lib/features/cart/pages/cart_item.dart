import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';
import 'package:new_app/features/cart/widgets/round_icon.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String size;
  final int quantity;
  final VoidCallback? onRemove;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  const CartItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.size,
    required this.quantity,
    this.onRemove,
    this.onIncrease,
    this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.network(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    RoundIcon(
                      icon: Icons.remove,
                      color: AppColors.greyLight,
                      onPressed: onDecrease,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "$quantity",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    RoundIcon(
                      icon: Icons.add,
                      color: AppColors.primary,
                      onPressed: onIncrease,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Size + Delete
          Column(
            children: [
            Text(
              size,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.delete, color: AppColors.error),
              onPressed: onRemove,
            ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
