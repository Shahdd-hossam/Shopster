import '../../../core/errors/failures.dart';
import '../../../core/hive/hive_service.dart';
import '../../models/favorites_hive_model.dart';
import '../../../domain/entities/product_entity.dart';

abstract class FavoritesLocalDataSource {
  Future<List<ProductEntity>> getFavorites();
  Future<void> addToFavorites(ProductEntity product);
  Future<void> removeFromFavorites(int productId);
  Future<void> clearFavorites();
  Future<bool> isFavorite(int productId);
  Future<void> cacheFavorites(List<ProductEntity> products);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String _favoritesKey = 'user_favorites';

  @override
  Future<List<ProductEntity>> getFavorites() async {
    try {
      final box = HiveService.favoritesBox;
      final favoritesData = box.get(_favoritesKey);
      
      if (favoritesData != null) {
        final favoritesModel = FavoritesHiveModel.fromJson(
          Map<String, dynamic>.from(favoritesData),
        );
        return favoritesModel.toEntities();
      }
      return [];
    } catch (e) {
      throw CacheFailure('Error getting favorites: $e');
    }
  }

  @override
  Future<void> addToFavorites(ProductEntity product) async {
    try {
      final currentFavorites = await getFavorites();
      
      // Check if product is not already in favorites
      if (!currentFavorites.any((fav) => fav.id == product.id)) {
        currentFavorites.add(product);
        await cacheFavorites(currentFavorites);
      }
    } catch (e) {
      throw CacheFailure('Error adding to favorites: $e');
    }
  }

  @override
  Future<void> removeFromFavorites(int productId) async {
    try {
      final currentFavorites = await getFavorites();
      currentFavorites.removeWhere((product) => product.id == productId);
      await cacheFavorites(currentFavorites);
    } catch (e) {
      throw CacheFailure('Error removing from favorites: $e');
    }
  }

  @override
  Future<void> clearFavorites() async {
    try {
      final box = HiveService.favoritesBox;
      await box.delete(_favoritesKey);
    } catch (e) {
      throw CacheFailure('Error clearing favorites: $e');
    }
  }

  @override
  Future<bool> isFavorite(int productId) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((product) => product.id == productId);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> cacheFavorites(List<ProductEntity> products) async {
    try {
      final box = HiveService.favoritesBox;
      final favoritesModel = FavoritesHiveModel.fromEntities(products);
      await box.put(_favoritesKey, favoritesModel.toJson());
    } catch (e) {
      throw CacheFailure('Error caching favorites: $e');
    }
  }
}
