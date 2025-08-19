import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local/product_local_data_source.dart';
import '../datasources/remote/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return Either.right(remoteProducts.map((product) => product.toEntity()).toList());
      } on ServerException catch (e) {
        return Either.left(ServerFailure(e.message));
      }
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        return Either.right(localProducts.map((product) => product.toEntity()).toList());
      } on CacheException catch (e) {
        return Either.left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(id);
        await localDataSource.cacheProduct(remoteProduct);
        return Either.right(remoteProduct.toEntity());
      } on ServerException catch (e) {
        return Either.left(ServerFailure(e.message));
      }
    } else {
      try {
        final localProduct = await localDataSource.getCachedProduct(id);
        return Either.right(localProduct.toEntity());
      } on CacheException catch (e) {
        return Either.left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remoteDataSource.getCategories();
        return Either.right(categories);
      } on ServerException catch (e) {
        return Either.left(ServerFailure(e.message));
      }
    } else {
      return Either.left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(String category) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProductsByCategory(category);
        return Either.right(products.map((product) => product.toEntity()).toList());
      } on ServerException catch (e) {
        return Either.left(ServerFailure(e.message));
      }
    } else {
      return Either.left(NetworkFailure('No internet connection'));
    }
  }
}
