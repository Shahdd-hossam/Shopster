import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/product_model.dart';

class FavoritesService extends ChangeNotifier {
  List<Product> _favorites = [];
  static const String _favoritesKey = 'user_favorites';

  // Getters
  List<Product> get favorites => _favorites;
  int get favoritesCount => _favorites.length;

  FavoritesService() {
    _loadFavorites();
  }

  // Load favorites from local storage
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString(_favoritesKey);
      
      if (favoritesJson != null) {
        final List<dynamic> favoritesList = json.decode(favoritesJson);
        _favorites = favoritesList
            .map((item) => Product.fromJson(item))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  // Save favorites to local storage
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = json.encode(
        _favorites.map((product) => product.toJson()).toList(),
      );
      await prefs.setString(_favoritesKey, favoritesJson);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  // Add product to favorites
  Future<void> addToFavorites(Product product) async {
    if (!isFavorite(product.id)) {
      _favorites.add(product);
      await _saveFavorites();
      notifyListeners();
    }
  }

  // Remove product from favorites
  Future<void> removeFromFavorites(int productId) async {
    _favorites.removeWhere((product) => product.id == productId);
    await _saveFavorites();
    notifyListeners();
  }

  // Toggle favorite status
  Future<void> toggleFavorite(Product product) async {
    if (isFavorite(product.id)) {
      await removeFromFavorites(product.id!);
    } else {
      await addToFavorites(product);
    }
  }

  // Check if product is in favorites
  bool isFavorite(int? productId) {
    if (productId == null) return false;
    return _favorites.any((product) => product.id == productId);
  }

  // Clear all favorites
  Future<void> clearFavorites() async {
    _favorites.clear();
    await _saveFavorites();
    notifyListeners();
  }

  // Get favorite product by ID
  Product? getFavoriteById(int productId) {
    try {
      return _favorites.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }
}
