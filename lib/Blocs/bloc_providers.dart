import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../data/datasources/local/cart_local_data_source.dart';
import '../data/datasources/local/favorites_local_data_source.dart';
import '../data/datasources/local/product_local_data_source.dart';
import '../data/datasources/remote/product_remote_data_source.dart';
import '../data/repositories/product_repository_impl.dart';
import '../core/network/network_info.dart';
import 'blocs/cart/cart_bloc.dart';
import 'blocs/cart/cart_event.dart';
import 'blocs/favorites/favorites_bloc.dart';
import 'blocs/favorites/favorites_event.dart';
import 'blocs/product/product_bloc.dart';
import 'blocs/product/product_event.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Product BLoC
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(
            productRepository: ProductRepositoryImpl(
              remoteDataSource: ProductRemoteDataSourceImpl(
                dio: Dio(),
              ),
              localDataSource: ProductLocalDataSourceImpl(),
              networkInfo: NetworkInfoImpl(
                Connectivity(),
              ),
            ),
          )..add(LoadProducts()),
        ),
        
        // Cart BLoC
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(
            localDataSource: CartLocalDataSourceImpl(),
          )..add(LoadCartEvent()),
        ),
        
        // Favorites BLoC
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(
            localDataSource: FavoritesLocalDataSourceImpl(),
          )..add(LoadFavoritesEvent()),
        ),
      ],
      child: child,
    );
  }
}
