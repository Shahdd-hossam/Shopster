import 'package:equatable/equatable.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../domain/entities/product_entity.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;

  const CartLoaded({required this.items});

  @override
  List<Object> get props => [items];

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  bool get isEmpty => items.isEmpty;
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object> get props => [message];
}

class CartItemAdded extends CartState {
  final ProductEntity product;

  const CartItemAdded({required this.product});

  @override
  List<Object> get props => [product];
}

class CartItemRemoved extends CartState {
  final int productId;

  const CartItemRemoved({required this.productId});

  @override
  List<Object> get props => [productId];
}

class CartItemUpdated extends CartState {
  final int productId;
  final int quantity;

  const CartItemUpdated({required this.productId, required this.quantity});

  @override
  List<Object> get props => [productId, quantity];
}
