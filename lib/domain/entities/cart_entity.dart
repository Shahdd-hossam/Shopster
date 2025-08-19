import 'product_entity.dart';

class CartEntity {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartItemEntity> products;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });
}

class CartItemEntity {
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;
}
