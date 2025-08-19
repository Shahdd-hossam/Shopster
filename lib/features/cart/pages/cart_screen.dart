import 'package:flutter/material.dart';
import 'package:new_app/common/bottomnav_bar.dart';
import 'package:new_app/core/services/cart_service.dart';
import 'package:new_app/features/cart/pages/cart_item.dart';
import 'package:new_app/features/cart/widgets/checkout_section.dart';
import 'package:new_app/features/cart/widgets/price_row.dart';
import 'package:new_app/features/cart/widgets/round_icon.dart';
import 'package:new_app/common/app_colors.dart';
import 'package:new_app/core/di/product_service_locator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  late CartService cartService;

  @override
  void initState() {
    super.initState();
    cartService = sl<CartService>();
    cartService.addListener(onCartChanged);
  }

  @override
  void dispose() {
    cartService.removeListener(onCartChanged);
    super.dispose();
  }

  void onCartChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          if (!cartService.isEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep, color: AppColors.error),
              onPressed: () => showClearCartDialog(context),
            ),
        ],
      ),
      body: cartService.isEmpty
          ? buildEmptyCart(context)
          : Column(
              children: [
                // Cart Items List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartService.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartService.cartItems[index];
                      return CartItem(
                        title: cartItem.product.title,
                        imageUrl: cartItem.product.image,
                        price: cartItem.product.price,
                        size: cartItem.product.category.toUpperCase(),
                        quantity: cartItem.quantity,
                        onIncrease: () async {
                          await cartService.increaseQuantity(cartItem.product.id!);
                        },
                        onDecrease: () async {
                          await cartService.decreaseQuantity(cartItem.product.id!);
                        },
                        onRemove: () async {
                          await cartService.removeFromCart(cartItem.product.id!);
                          showSnackBar('${cartItem.product.title} removed from cart', AppColors.error);
                        },
                      );
                    },
                  ),
                ),

                // Checkout Section
                CheckoutSection(
                  roundIcon: RoundIcon(
                    icon: Icons.shopping_cart_checkout,
                    color: AppColors.primary,
                  ),
                  priceRow: (label, value, {bold = false}) => PriceRow(
                    label: label,
                    value: value,
                    bold: bold,
                  ),
                  subtotal: cartService.subtotal,
                  shipping: cartService.shippingCost,
                  total: cartService.total,
                  onCheckout: handleCheckout,
                ),
                BottomNavBar(
                  onHomePressed: () => Navigator.pushReplacementNamed(context, '/home'),
                  onCartPressed: () => Navigator.pushReplacementNamed(context, '/cart'),
                  onProfilePressed: () => Navigator.pushReplacementNamed(context, '/profile'),
                ),
              ],
            ),
    );
  }

  Widget buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: AppColors.grey,
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Add some products to get started',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textLight,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  void showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text('Clear Cart', style: TextStyle(color: AppColors.textPrimary)),
          content: Text(
            'Are you sure you want to remove all items from your cart?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
            ),
            TextButton(
              onPressed: () async {
                await cartService.clearCart();
                Navigator.of(context).pop();
                showSnackBar('Cart cleared', AppColors.success);
              },
              child: Text('Clear', style: TextStyle(color: AppColors.error)),
            ),
          ],
        );
      },
    );
  }

  void handleCheckout() {
    showSnackBar(
      'Checkout functionality coming soon! Total: \$${cartService.total.toStringAsFixed(2)}',
      AppColors.primary,
    );
  }

  void showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
