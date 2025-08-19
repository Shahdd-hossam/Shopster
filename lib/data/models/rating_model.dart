import 'package:new_app/remote/api_keys.dart';
import '../../domain/entities/product_entity.dart';

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json[ApiKeys.rate] as num).toDouble(),
      count: json[ApiKeys.count],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.rate: rate,
      ApiKeys.count: count,
    };
  }

  // Convert to domain entity
  RatingEntity toEntity() {
    return RatingEntity(
      rate: rate,
      count: count,
    );
  }

  // Create from domain entity
  factory Rating.fromEntity(RatingEntity entity) {
    return Rating(
      rate: entity.rate,
      count: entity.count,
    );
  }
}