import 'package:new_app/data/models/rating_model.dart';
import 'package:new_app/remote/api_keys.dart';
import '../../domain/entities/product_entity.dart';

class Product {
  final int? id;
  final String title;
  final String image;
  final String description;
  final String category;
  final double price;
  final Rating? rating;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
    this.rating,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingJson = json[ApiKeys.rating];
    return Product(
      id: json[ApiKeys.id],
      title: (json[ApiKeys.title] ?? '').toString(),
      image: (json[ApiKeys.image] ?? '').toString(),
      price: ((json[ApiKeys.price]) as num?)?.toDouble() ?? 0.0,
      description: (json[ApiKeys.description] ?? '').toString(),
      category: (json[ApiKeys.category] ?? '').toString(),
      rating: ratingJson is Map<String, dynamic> ? Rating.fromJson(ratingJson) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.title: title,
      ApiKeys.image: image,
      ApiKeys.price: price,
      ApiKeys.description: description,
      ApiKeys.category: category,
      ApiKeys.rating: rating?.toJson(),
    };
  }

  // Convert to domain entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? 0,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating?.toEntity(),
    );
  }

  // Create from domain entity
  factory Product.fromEntity(ProductEntity entity) {
    return Product(
      id: entity.id,
      title: entity.title,
      image: entity.image,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      rating: entity.rating != null ? Rating.fromEntity(entity.rating!) : null,
    );
  }
}

