import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class LoadProduct extends ProductEvent {
  final int productId;

  const LoadProduct({required this.productId});

  @override
  List<Object> get props => [productId];
}

class LoadCategories extends ProductEvent {}

class LoadProductsByCategory extends ProductEvent {
  final String category;

  const LoadProductsByCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class RefreshProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts({required this.query});

  @override
  List<Object> get props => [query];
}
