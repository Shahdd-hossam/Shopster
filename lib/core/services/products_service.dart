import 'package:new_app/remote/api_constants.dart';
import 'package:new_app/data/models/product_model.dart';
import 'package:new_app/remote/api_service.dart';

class ProductsService {
  final ApiService apiService;
  ProductsService({required this.apiService});

  Future<List<Product>> getProducts() async {
    try {
      final response = await apiService.get(path: ApiConstants.products);
      final List<dynamic> dataList = response.data as List;
      if (response.statusCode == 200) {
        return dataList.map((e) => Product.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow; // == throw(e)
    }
  }

  Future<Product?> getProductById(int id) async {
    try {
      final response = await apiService.get(path: '${ApiConstants.products}/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow; // == throw(e)
    }
  }

  // Get products filtered by category
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final encoded = Uri.encodeComponent(category);
      final response = await apiService.get(path: '${ApiConstants.productsInCategory}$encoded');
      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data as List;
        return dataList.map((e) => Product.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}

