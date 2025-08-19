import 'package:flutter/material.dart';
import 'package:new_app/data/models/product_model.dart';
import 'package:new_app/features/products/product_card.dart';
import 'package:new_app/features/products/product_details_page.dart';
import 'package:new_app/common/app_colors.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;
  final bool isLoading;

  const ProductsList({
    super.key,
    required this.products,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 64,
              color: AppColors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 16, 
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  product: products[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
