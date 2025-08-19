import 'package:equatable/equatable.dart';
import '../../../domain/entities/product_entity.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<ProductEntity> favorites;

  const FavoritesLoaded({required this.favorites});

  @override
  List<Object> get props => [favorites];

  bool get isEmpty => favorites.isEmpty;
  
  bool isFavorite(int productId) {
    return favorites.any((product) => product.id == productId);
  }
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteAdded extends FavoritesState {
  final ProductEntity product;

  const FavoriteAdded({required this.product});

  @override
  List<Object> get props => [product];
}

class FavoriteRemoved extends FavoritesState {
  final int productId;

  const FavoriteRemoved({required this.productId});

  @override
  List<Object> get props => [productId];
}
