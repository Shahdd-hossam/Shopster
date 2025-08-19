
import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';
import 'package:new_app/core/services/favorites_service.dart';
import 'package:new_app/core/di/product_service_locator.dart';
import 'package:new_app/features/products/product_card.dart';
import 'package:new_app/features/products/product_details_page.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesService favoritesService;

  @override
  void initState() {
    super.initState();
    favoritesService = sl<FavoritesService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        actions: [
          ListenableBuilder(
            listenable: favoritesService,
            builder: (context, child) {
              return favoritesService.favorites.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_all, color: Colors.white),
                      onPressed: () => _showClearAllDialog(),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: favoritesService,
        builder: (context, child) {
          if (favoritesService.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 100,
                    color: AppColors.grey,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Start adding products to your favorites!',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header with count
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${favoritesService.favoritesCount} favorite${favoritesService.favoritesCount == 1 ? '' : 's'}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Favorites grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: favoritesService.favorites.length,
                    itemBuilder: (context, index) {
                      final product = favoritesService.favorites[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Favorites'),
          content: const Text('Are you sure you want to remove all favorites?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                favoritesService.clearFavorites();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('All favorites cleared'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              child: Text(
                'Clear All',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}