class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingEntity? rating;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });
}

class RatingEntity {
  final double rate;
  final int count;

  const RatingEntity({
    required this.rate,
    required this.count,
  });
}
