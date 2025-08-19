import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasources/local/cart_local_data_source.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartLocalDataSource _localDataSource;

  CartBloc({required CartLocalDataSource localDataSource})
      : _localDataSource = localDataSource,
        super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartQuantityEvent>(_onUpdateCartQuantity);
    on<ClearCartEvent>(_onClearCart);
    on<GetCartTotalEvent>(_onGetCartTotal);
  }

  Future<void> _onLoadCart(
    LoadCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoading());
      final cartItems = await _localDataSource.getCartItems();
      emit(CartLoaded(items: cartItems));
    } catch (e) {
      emit(CartError(message: 'Failed to load cart: ${e.toString()}'));
    }
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _localDataSource.addToCart(event.product);
      
      // Emit temporary state for feedback
      emit(CartItemAdded(product: event.product));
      
      // Then reload cart to show updated state
      add(LoadCartEvent());
    } catch (e) {
      emit(CartError(message: 'Failed to add item to cart: ${e.toString()}'));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _localDataSource.removeFromCart(event.productId);
      
      // Emit temporary state for feedback
      emit(CartItemRemoved(productId: event.productId));
      
      // Then reload cart to show updated state
      add(LoadCartEvent());
    } catch (e) {
      emit(CartError(message: 'Failed to remove item from cart: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateCartQuantity(
    UpdateCartQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _localDataSource.updateQuantity(
        event.productId,
        event.quantity,
      );
      
      // Emit temporary state for feedback
      emit(CartItemUpdated(
        productId: event.productId,
        quantity: event.quantity,
      ));
      
      // Then reload cart to show updated state
      add(LoadCartEvent());
    } catch (e) {
      emit(CartError(message: 'Failed to update cart quantity: ${e.toString()}'));
    }
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _localDataSource.clearCart();
      emit(const CartLoaded(items: []));
    } catch (e) {
      emit(CartError(message: 'Failed to clear cart: ${e.toString()}'));
    }
  }

  Future<void> _onGetCartTotal(
    GetCartTotalEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      // Get current cart items and calculate total
      final items = await _localDataSource.getCartItems();
      
      // If we have a current loaded state, update it with items
      if (state is CartLoaded) {
        emit(CartLoaded(items: items));
      } else {
        // Otherwise load the cart
        add(LoadCartEvent());
      }
    } catch (e) {
      emit(CartError(message: 'Failed to get cart total: ${e.toString()}'));
    }
  }
}
