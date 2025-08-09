class Product {
  final int id;
  final String name;
  final double price;
  final double? originalPrice;
  final String image;
  final String category;
  final double rating;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.image,
    required this.category,
    required this.rating,
    required this.description,
    required this.sizes,
    required this.colors,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      originalPrice: json['originalPrice']?.toDouble(),
      image: json['image'],
      category: json['category'],
      rating: json['rating'].toDouble(),
      description: json['description'],
      sizes: List<String>.from(json['sizes']),
      colors: List<String>.from(json['colors']),
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
