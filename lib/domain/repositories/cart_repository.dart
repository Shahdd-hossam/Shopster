import '../../core/errors/failures.dart';
import '../entities/cart_entity.dart';
import '../entities/product_entity.dart';
import 'product_repository.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemEntity>>> getCartItems();
  Future<Either<Failure, void>> addToCart(ProductEntity product);
  Future<Either<Failure, void>> removeFromCart(int productId);
  Future<Either<Failure, void>> updateQuantity(int productId, int quantity);
  Future<Either<Failure, void>> clearCart();
}
