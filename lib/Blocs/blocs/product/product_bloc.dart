import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProduct>(_onLoadProduct);
    on<LoadCategories>(_onLoadCategories);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<RefreshProducts>(_onRefreshProducts);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    
    final result = await productRepository.getProducts();
    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }

  Future<void> _onLoadProduct(
    LoadProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    
    final result = await productRepository.getProduct(event.productId);
    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (product) => emit(ProductLoaded(products: [product])),
    );
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    
    final result = await productRepository.getCategories();
    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (categories) => emit(ProductCategoriesLoaded(categories: categories)),
    );
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    
    final result = await productRepository.getProductsByCategory(event.category);
    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    // Force refresh from remote
    final result = await productRepository.getProducts();
    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductLoaded) {
      final currentProducts = (state as ProductLoaded).products;
      final filteredProducts = currentProducts
          .where((product) => 
            product.title.toLowerCase().contains(event.query.toLowerCase()) ||
            product.category.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      
      emit(ProductLoaded(products: filteredProducts));
    } else {
      // Load all products first, then search
      final result = await productRepository.getProducts();
      result.fold(
        (failure) => emit(ProductError(message: failure.message)),
        (products) {
          final filteredProducts = products
              .where((product) => 
                product.title.toLowerCase().contains(event.query.toLowerCase()) ||
                product.category.toLowerCase().contains(event.query.toLowerCase()))
              .toList();
          emit(ProductLoaded(products: filteredProducts));
        },
      );
    }
  }
}
