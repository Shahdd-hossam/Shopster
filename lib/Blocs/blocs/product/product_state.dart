import 'package:equatable/equatable.dart';
import '../../../domain/entities/product_entity.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;

  const ProductLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductCategoriesLoaded extends ProductState {
  final List<String> categories;

  const ProductCategoriesLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}
