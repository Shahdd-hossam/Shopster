import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// Core
import '../network/network_info.dart';
import '../hive/hive_service.dart';

// Data Sources
import '../../data/datasources/remote/product_remote_data_source.dart';
import '../../data/datasources/local/product_local_data_source.dart';

// Repositories
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';

// Services (keeping your existing ones for now)
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/favorites_service.dart';
import '../services/products_service.dart';
import '../../remote/api_service.dart';

final sl = GetIt.instance;

Future<void> setupDI() async {
  // Initialize Hive
  await HiveService.init();

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  
  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<ApiService>(() => ApiService());

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl()),
  );
  
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Services (keeping existing ones)
  sl.registerLazySingleton<AuthService>(
    () => AuthService(apiService: sl<ApiService>()),
  );
  
  sl.registerLazySingleton<CartService>(
    () => CartService(dio: sl<ApiService>().dio, authService: sl<AuthService>()),
  );
  
  sl.registerLazySingleton<FavoritesService>(
    () => FavoritesService(),
  );
  
  sl.registerLazySingleton<ProductsService>(
    () => ProductsService(apiService: sl<ApiService>()),
  );
}
