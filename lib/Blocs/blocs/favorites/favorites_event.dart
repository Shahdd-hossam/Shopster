import 'package:equatable/equatable.dart';
import '../../../domain/entities/product_entity.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {}

class AddToFavoritesEvent extends FavoritesEvent {
  final ProductEntity product;

  const AddToFavoritesEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromFavoritesEvent extends FavoritesEvent {
  final int productId;

  const RemoveFromFavoritesEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final ProductEntity product;

  const ToggleFavoriteEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class CheckIsFavoriteEvent extends FavoritesEvent {
  final int productId;

  const CheckIsFavoriteEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class ClearFavoritesEvent extends FavoritesEvent {}
