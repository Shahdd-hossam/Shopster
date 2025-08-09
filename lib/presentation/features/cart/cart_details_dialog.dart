import 'package:flutter/material.dart';
import 'package:new_task/core/models/cart.dart';

class CartDetailsDialog extends StatelessWidget {
  final Cart cart;
  final VoidCallback? onDelete;

  const CartDetailsDialog({
    super.key,
    required this.cart,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cart #${cart.id}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('User ID:', '${cart.userId}'),
          _buildDetailRow('Date:', cart.date),
          _buildDetailRow('Products:', '${cart.products.length} items'),
          const SizedBox(height: 16),
          const Text(
            'Products:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...cart.products.map((product) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text('• Product ID: ${product['productId']}, Qty: ${product['quantity']}'),
          )),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        if (onDelete != null)
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete!();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required Cart cart,
    VoidCallback? onDelete,
  }) {
    return showDialog(
      context: context,
      builder: (context) => CartDetailsDialog(
        cart: cart,
        onDelete: onDelete,
      ),
    );
  }
}