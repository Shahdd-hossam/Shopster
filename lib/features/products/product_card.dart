
import 'package:flutter/material.dart';
import 'package:new_app/data/models/product_model.dart';
import 'package:new_app/common/app_colors.dart';
import 'package:new_app/animations/fadeinimage.dart';
import 'package:new_app/core/services/cart_service.dart';
import 'package:new_app/core/services/favorites_service.dart';
import 'package:new_app/core/di/product_service_locator.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;
  const ProductCard({super.key, required this.product, this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late FavoritesService favoritesService;

  @override
  void initState() {
    super.initState();
    favoritesService = sl<FavoritesService>();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        shadowColor: AppColors.grey.withOpacity(0.3),
        color: AppColors.surface,
        child: SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Product image
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: FadeInImageAnimation(url: widget.product.image),
                    ),

                    // Favorite icon with white rounded background
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.15),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListenableBuilder(
                          listenable: favoritesService,
                          builder: (context, child) {
                            final isFavorite = favoritesService.isFavorite(widget.product.id);
                            return IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                size: 18,
                                color: AppColors.error,
                              ),
                              onPressed: () async {
                                await favoritesService.toggleFavorite(widget.product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isFavorite 
                                          ? '${widget.product.title} removed from favorites'
                                          : '${widget.product.title} added to favorites',
                                    ),
                                    backgroundColor: isFavorite ? AppColors.error : AppColors.success,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              padding: const EdgeInsets.all(6),
                              constraints: const BoxConstraints(),
                            );
                          },
                        ),
                      ),
                    ),

                    // Shopping bag icon with white rounded background
                    Positioned(
                      bottom: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.15),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.shopping_bag_outlined, size: 15, color: AppColors.primary),
                          onPressed: () async {
                            try {
                              final cartService = sl<CartService>();
                              await cartService.addToCart(widget.product);
                              
                              // Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${widget.product.title} added to cart'),
                                  backgroundColor: AppColors.success,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error adding to cart: $e'),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                            }
                          },
                          padding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ]
                ),
              ),

              // 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  widget.product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 12),
                child: Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: AppColors.primary, 
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

