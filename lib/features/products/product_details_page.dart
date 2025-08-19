import 'package:flutter/material.dart';
import 'package:new_app/data/models/product_model.dart';
import 'package:new_app/common/app_colors.dart';


class ProductDetailsPage extends StatefulWidget {
  final Product product; 

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => ProductDetailsPageState();
}

class ProductDetailsPageState extends State<ProductDetailsPage> {
  Product? product; // fetch by id

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background image
            Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 120),
              child: Image(
                image: NetworkImage(product!.image.toString()),
                fit: BoxFit.contain,
              ),
            ),
            ),

          // Top icons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.favorite_border, color: AppColors.error),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.shopping_cart, color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ),

          // Swipe-up product details
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          height: 5,
                          width: 50,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        product!.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product!.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "\$${product!.price}",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
