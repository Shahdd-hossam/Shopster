import '../../core/errors/failures.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, ProductEntity>> getProduct(int id);
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(String category);
}

// Simple Either implementation
class Either<L, R> {
  final L? _left;
  final R? _right;

  const Either.left(L value) : _left = value, _right = null;
  const Either.right(R value) : _left = null, _right = value;

  bool get isLeft => _left != null;
  bool get isRight => _right != null;

  L get left => _left!;
  R get right => _right!;

  T fold<T>(T Function(L) leftFn, T Function(R) rightFn) {
    if (isLeft) {
      return leftFn(_left!);
    } else {
      return rightFn(_right!);
    }
  }
}
