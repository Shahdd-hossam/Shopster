import 'package:new_task/core/services/product_service.dart';
import '../models/product.dart';

class ProductController {
  final ProductService _productService = ProductService();

  Future<List<Product>> getAllProducts() async {
    return await _productService.fetchProducts();
  }

  Future<Product?> getProduct(int id) async {
    return await _productService.getProductById(id);
  }

  Future<Product?> updateProduct(int id, Map<String, dynamic> data) async {
    return await _productService.updateProduct(id, data);
  }

  Future<Product?> addProduct(Map<String, dynamic> data) async {
    return await _productService.addProduct(data);
  }

  Future<bool> deleteProduct(int id) async {
    return await _productService.deleteProduct(id);
  }
}
