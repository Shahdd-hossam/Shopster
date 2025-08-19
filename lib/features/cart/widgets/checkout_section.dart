import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';

class CheckoutSection extends StatelessWidget {
  final Widget roundIcon;
  final Widget Function(String, String, {bool bold}) priceRow;
  final double subtotal;
  final double shipping;
  final double total;
  final VoidCallback? onCheckout;

  const CheckoutSection({
    super.key,
    required this.roundIcon,
    required this.priceRow,
    required this.subtotal,
    required this.shipping,
    required this.total,
    this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          roundIcon,
          const SizedBox(height: 16),
          
          priceRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          priceRow("Shipping", shipping > 0 ? "\$${shipping.toStringAsFixed(2)}" : "Free"),
          const Divider(height: 24),
          priceRow("Total", "\$${total.toStringAsFixed(2)}", bold: true),
          
          const SizedBox(height: 24),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 2,
              ),
              onPressed: onCheckout,
              child: Text(
                "Proceed to Checkout",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

