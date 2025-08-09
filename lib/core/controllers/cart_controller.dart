import 'package:new_task/core/services/cart_service.dart';
import '../models/cart.dart';

class CartController {
  final CartService _cartService = CartService();

  Future<List<Cart>> getAllCarts() async {
    return await _cartService.fetchCarts();
  }

  Future<Cart?> getCart(int id) async {
    return await _cartService.getCartById(id);
  }

  Future<bool> deleteCart(int id) async {
    return await _cartService.deleteCart(id);
  }

  Future<Cart?> updateCart(int id, Map<String, dynamic> data) async {
    return await _cartService.updateCart(id, data);
  }

  Future<Cart?> addCart(Map<String, dynamic> data) async {
    return await _cartService.addCart(data);
  }
}
