import 'package:equatable/equatable.dart';
import '../../../domain/entities/product_entity.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductEntity product;

  const AddToCartEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;

  const RemoveFromCartEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class UpdateCartQuantityEvent extends CartEvent {
  final int productId;
  final int quantity;

  const UpdateCartQuantityEvent({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object> get props => [productId, quantity];
}

class ClearCartEvent extends CartEvent {}

class GetCartTotalEvent extends CartEvent {}
