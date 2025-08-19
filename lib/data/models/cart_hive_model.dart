import 'package:hive/hive.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/product_entity.dart';

part 'cart_hive_model.g.dart';

@HiveType(typeId: 0)
class CartHiveModel extends HiveObject {
  @HiveField(0)
  final List<CartItemHiveModel> items;

  @HiveField(1)
  final DateTime lastUpdated;

  CartHiveModel({
    required this.items,
    required this.lastUpdated,
  });

  factory CartHiveModel.fromJson(Map<String, dynamic> json) {
    return CartHiveModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => CartItemHiveModel.fromJson(item))
          .toList() ?? [],
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  List<CartItemEntity> toEntities() {
    return items.map((item) => item.toEntity()).toList();
  }

  factory CartHiveModel.fromEntities(List<CartItemEntity> entities) {
    return CartHiveModel(
      items: entities.map((entity) => CartItemHiveModel.fromEntity(entity)).toList(),
      lastUpdated: DateTime.now(),
    );
  }

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}

@HiveType(typeId: 7)
class CartItemHiveModel extends HiveObject {
  @HiveField(0)
  final ProductHiveModel product;

  @HiveField(1)
  final int quantity;

  CartItemHiveModel({
    required this.product,
    required this.quantity,
  });

  factory CartItemHiveModel.fromJson(Map<String, dynamic> json) {
    return CartItemHiveModel(
      product: ProductHiveModel.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      product: product.toEntity(),
      quantity: quantity,
    );
  }

  factory CartItemHiveModel.fromEntity(CartItemEntity entity) {
    return CartItemHiveModel(
      product: ProductHiveModel.fromEntity(entity.product),
      quantity: entity.quantity,
    );
  }

  double get totalPrice => product.price * quantity;
}

@HiveType(typeId: 8)
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

@HiveType(typeId: 9)
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
