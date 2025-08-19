import 'package:hive/hive.dart';
import '../../domain/entities/product_entity.dart';

part 'favorites_hive_model.g.dart';

@HiveType(typeId: 1)
class FavoritesHiveModel extends HiveObject {
  @HiveField(0)
  final List<ProductHiveModel> products;

  @HiveField(1)
  final DateTime lastUpdated;

  FavoritesHiveModel({
    required this.products,
    required this.lastUpdated,
  });

  factory FavoritesHiveModel.fromJson(Map<String, dynamic> json) {
    return FavoritesHiveModel(
      products: (json['products'] as List<dynamic>?)
          ?.map((product) => ProductHiveModel.fromJson(product))
          .toList() ?? [],
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((product) => product.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  List<ProductEntity> toEntities() {
    return products.map((product) => product.toEntity()).toList();
  }

  factory FavoritesHiveModel.fromEntities(List<ProductEntity> entities) {
    return FavoritesHiveModel(
      products: entities.map((entity) => ProductHiveModel.fromEntity(entity)).toList(),
      lastUpdated: DateTime.now(),
    );
  }

  bool isFavorite(int productId) {
    return products.any((product) => product.id == productId);
  }

  void addProduct(ProductEntity product) {
    if (!isFavorite(product.id)) {
      products.add(ProductHiveModel.fromEntity(product));
    }
  }

  void removeProduct(int productId) {
    products.removeWhere((product) => product.id == productId);
  }
}

@HiveType(typeId: 11)
class ProductHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final RatingHiveModel? rating;

  ProductHiveModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  factory ProductHiveModel.fromJson(Map<String, dynamic> json) {
    return ProductHiveModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      rating: json['rating'] != null 
          ? RatingHiveModel.fromJson(json['rating']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating?.toJson(),
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating?.toEntity(),
    );
  }

  factory ProductHiveModel.fromEntity(ProductEntity entity) {
    return ProductHiveModel(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      image: entity.image,
      rating: entity.rating != null 
          ? RatingHiveModel.fromEntity(entity.rating!) 
          : null,
    );
  }
}

@HiveType(typeId: 12)
class RatingHiveModel extends HiveObject {
  @HiveField(0)
  final double rate;

  @HiveField(1)
  final int count;

  RatingHiveModel({
    required this.rate,
    required this.count,
  });

  factory RatingHiveModel.fromJson(Map<String, dynamic> json) {
    return RatingHiveModel(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  RatingEntity toEntity() {
    return RatingEntity(
      rate: rate,
      count: count,
    );
  }

  factory RatingHiveModel.fromEntity(RatingEntity entity) {
    return RatingHiveModel(
      rate: entity.rate,
      count: entity.count,
    );
  }
}
