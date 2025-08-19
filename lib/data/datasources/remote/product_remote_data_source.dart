import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts();
  Future<Product> getProduct(int id);
  Future<List<String>> getCategories();
  Future<List<Product>> getProductsByCategory(String category);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await dio.get(ApiConstants.products);
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load products');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }

  @override
  Future<Product> getProduct(int id) async {
    try {
      final response = await dio.get(ApiConstants.products + '/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw ServerException('Failed to load product');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await dio.get(ApiConstants.categories);
      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = response.data;
        return categoriesJson.map((category) => category.toString()).toList();
      } else {
        throw ServerException('Failed to load categories');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response = await dio.get(ApiConstants.productsInCategory.replaceFirst('{category}', category));
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load products by category');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    }
  }
}
