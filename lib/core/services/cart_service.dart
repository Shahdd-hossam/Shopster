import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart.dart';

class CartService {
  final String baseUrl = 'https://fakestoreapi.com/carts';

  Future<List<Cart>> fetchCarts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Cart.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load carts');
    }
  }

  Future<Cart?> getCartById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Cart.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<bool> deleteCart(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200;
  }

  Future<Cart?> updateCart(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Cart.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<Cart?> addCart(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Cart.fromJson(json.decode(response.body));
    }
    return null;
  }
}
