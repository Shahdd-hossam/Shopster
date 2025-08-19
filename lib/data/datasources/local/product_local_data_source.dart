import '../../../core/errors/exceptions.dart';
import '../../../core/hive/hive_service.dart';
import '../../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getCachedProducts();
  Future<void> cacheProducts(List<Product> products);
  Future<Product> getCachedProduct(int id);
  Future<void> cacheProduct(Product product);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<List<Product>> getCachedProducts() async {
    try {
      final box = HiveService.productsBox;
      final productsMap = box.get('products');
      
      if (productsMap != null) {
        final List<dynamic> productsList = productsMap['data'];
        return productsList.map((json) => Product.fromJson(Map<String, dynamic>.from(json))).toList();
      } else {
        throw CacheException('No cached products found');
      }
    } catch (e) {
      throw CacheException('Error getting cached products: $e');
    }
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    try {
      final box = HiveService.productsBox;
      final productsData = {
        'data': products.map((product) => product.toJson()).toList(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      await box.put('products', productsData);
    } catch (e) {
      throw CacheException('Error caching products: $e');
    }
  }

  @override
  Future<Product> getCachedProduct(int id) async {
    try {
      final box = HiveService.productsBox;
      final productMap = box.get('product_$id');
      
      if (productMap != null) {
        return Product.fromJson(Map<String, dynamic>.from(productMap['data']));
      } else {
        throw CacheException('No cached product found for id: $id');
      }
    } catch (e) {
      throw CacheException('Error getting cached product: $e');
    }
  }

  @override
  Future<void> cacheProduct(Product product) async {
    try {
      final box = HiveService.productsBox;
      final productData = {
        'data': product.toJson(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      await box.put('product_${product.id}', productData);
    } catch (e) {
      throw CacheException('Error caching product: $e');
    }
  }
}
