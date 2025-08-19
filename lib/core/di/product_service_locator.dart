import 'package:get_it/get_it.dart';
import 'package:new_app/remote/api_service.dart';
import 'package:new_app/core/services/products_service.dart';
import 'package:new_app/core/services/cart_service.dart';
import 'package:new_app/core/services/auth_service.dart';
import 'package:new_app/core/services/favorites_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Low level / external
  sl.registerLazySingleton<ApiService>(() => ApiService());

  // Auth service (registered first as others depend on it)
  sl.registerLazySingleton<AuthService>(
      () => AuthService(apiService: sl<ApiService>()));

  // Services
  sl.registerLazySingleton<ProductsService>(
      () => ProductsService(apiService: sl<ApiService>()));
  
  sl.registerLazySingleton<CartService>(
      () => CartService(dio: sl<ApiService>().dio, authService: sl<AuthService>()));
      
  sl.registerLazySingleton<FavoritesService>(
      () => FavoritesService());
}