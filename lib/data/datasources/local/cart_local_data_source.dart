import '../../../core/errors/failures.dart';
import '../../../core/hive/hive_service.dart';
import '../../models/cart_hive_model.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../domain/entities/product_entity.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemEntity>> getCartItems();
  Future<void> addToCart(ProductEntity product);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
  Future<void> cacheCart(List<CartItemEntity> items);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const String _cartKey = 'user_cart';

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    try {
      final box = HiveService.cartBox;
      final cartData = box.get(_cartKey);
      
      if (cartData != null) {
        final cartModel = CartHiveModel.fromJson(Map<String, dynamic>.from(cartData));
        return cartModel.toEntities();
      }
      return [];
    } catch (e) {
      throw CacheFailure('Error getting cart items: $e');
    }
  }

  @override
  Future<void> addToCart(ProductEntity product) async {
    try {
      final currentItems = await getCartItems();
      
      // Check if product already exists
      final existingIndex = currentItems.indexWhere(
        (item) => item.product.id == product.id,
      );
      
      if (existingIndex != -1) {
        // Update quantity
        currentItems[existingIndex] = CartItemEntity(
          product: product,
          quantity: currentItems[existingIndex].quantity + 1,
        );
      } else {
        // Add new item
        currentItems.add(CartItemEntity(
          product: product,
          quantity: 1,
        ));
      }
      
      await cacheCart(currentItems);
    } catch (e) {
      throw CacheFailure('Error adding to cart: $e');
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    try {
      final currentItems = await getCartItems();
      currentItems.removeWhere((item) => item.product.id == productId);
      await cacheCart(currentItems);
    } catch (e) {
      throw CacheFailure('Error removing from cart: $e');
    }
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      final currentItems = await getCartItems();
      final index = currentItems.indexWhere(
        (item) => item.product.id == productId,
      );
      
      if (index != -1) {
        if (quantity <= 0) {
          currentItems.removeAt(index);
        } else {
          currentItems[index] = CartItemEntity(
            product: currentItems[index].product,
            quantity: quantity,
          );
        }
        await cacheCart(currentItems);
      }
    } catch (e) {
      throw CacheFailure('Error updating cart quantity: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final box = HiveService.cartBox;
      await box.delete(_cartKey);
    } catch (e) {
      throw CacheFailure('Error clearing cart: $e');
    }
  }

  @override
  Future<void> cacheCart(List<CartItemEntity> items) async {
    try {
      final box = HiveService.cartBox;
      final cartModel = CartHiveModel.fromEntities(items);
      await box.put(_cartKey, cartModel.toJson());
    } catch (e) {
      throw CacheFailure('Error caching cart: $e');
    }
  }
}
