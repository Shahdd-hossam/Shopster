import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_app/data/models/cart_model.dart';
import 'package:new_app/data/models/product_model.dart';
import 'package:new_app/data/models/rating_model.dart';
import 'package:new_app/remote/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';

class CartService extends ChangeNotifier {
  final Dio dio;
  final AuthService? authService;
  List<CartItem> cartItems = [];
  double shippingCost = 5.99;
  
  CartService({required this.dio, this.authService}) {
    loadCartFromCache();
  }

  // Getters
  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  double get effectiveShippingCost => cartItems.isEmpty ? 0 : shippingCost;
  double get total => subtotal + (cartItems.isEmpty ? 0 : shippingCost);
  bool get isEmpty => cartItems.isEmpty;

  /// Load cart from local cache
  Future<void> loadCartFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString('cart_items');
      if (cartJson != null) {
        final List<dynamic> cartList = json.decode(cartJson);
        cartItems = cartList.map((item) => CartItem.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading cart from cache: $e');
    }
  }

  /// Save cart to local cache
  Future<void> saveCartToCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = json.encode(cartItems.map((item) => item.toJson()).toList());
      await prefs.setString('cart_items', cartJson);
    } catch (e) {
      debugPrint('Error saving cart to cache: $e');
    }
  }

  /// Add product to cart
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    try {
      final existingIndex = cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (existingIndex >= 0) {
        cartItems[existingIndex] = CartItem(
          product: product,
          quantity: cartItems[existingIndex].quantity + quantity,
        );
      } else {
        cartItems.add(CartItem(product: product, quantity: quantity));
      }

      await saveCartToCache();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  /// Remove product from cart
  Future<void> removeFromCart(int productId) async {
    try {
      cartItems.removeWhere((item) => item.product.id == productId);
      await saveCartToCache();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to remove item from cart: $e');
    }
  }

  /// Update product quantity
  Future<void> updateQuantity(int productId, int newQuantity) async {
    try {
      if (newQuantity <= 0) {
        await removeFromCart(productId);
        return;
      }

      final existingIndex = cartItems.indexWhere(
        (item) => item.product.id == productId,
      );

      if (existingIndex >= 0) {
        cartItems[existingIndex] = CartItem(
          product: cartItems[existingIndex].product,
          quantity: newQuantity,
        );
        await saveCartToCache();
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  /// Increase product quantity
  Future<void> increaseQuantity(int productId) async {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == productId,
    );
    
    if (existingIndex >= 0) {
      await updateQuantity(productId, cartItems[existingIndex].quantity + 1);
    }
  }

  /// Decrease product quantity
  Future<void> decreaseQuantity(int productId) async {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == productId,
    );
    
    if (existingIndex >= 0) {
      await updateQuantity(productId, cartItems[existingIndex].quantity - 1);
    }
  }

  /// Clear all items from cart
  Future<void> clearCart() async {
    try {
      cartItems.clear();
      await saveCartToCache();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  /// Check if product is in cart
  bool isInCart(int productId) {
    return cartItems.any((item) => item.product.id == productId);
  }

  /// Get cart item count for specific product
  int getProductQuantity(int productId) {
    final item = cartItems.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(
        product: Product(
          id: -1, 
          title: '', 
          price: 0, 
          description: '', 
          category: '', 
          image: '', 
          rating: Rating(rate: 0, count: 0)
        ), 
        quantity: 0
      ),
    );
    return item.product.id == -1 ? 0 : item.quantity;
  }

  /// API Operations (Future implementation)
  
  /// Get all carts from API
  Future<List<Cart>> getCarts() async {
    try {
      final response = await dio.get('${ApiConstants.baseUrl}${ApiConstants.carts}');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Cart.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load carts: $e');
    }
  }

  /// Get cart by userId
  Future<List<Cart>> getUserCart(int userId) async {
    try {
      final response = await dio.get('${ApiConstants.baseUrl}/carts/user/$userId');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => Cart.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load user cart: $e');
    }
  }

  /// Get single cart by cart id
  Future<Cart?> getCartById(int id) async {
    try {
      final response = await dio.get('${ApiConstants.baseUrl}${ApiConstants.carts}/$id');
      if (response.statusCode == 200) {
        return Cart.fromJson(response.data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load cart $id: $e');
    }
  }
}
