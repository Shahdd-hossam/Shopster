import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasources/local/favorites_local_data_source.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesLocalDataSource _localDataSource;

  FavoritesBloc({required FavoritesLocalDataSource localDataSource})
      : _localDataSource = localDataSource,
        super(FavoritesInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<AddToFavoritesEvent>(_onAddToFavorites);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<CheckIsFavoriteEvent>(_onCheckIsFavorite);
    on<ClearFavoritesEvent>(_onClearFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      emit(FavoritesLoading());
      final favorites = await _localDataSource.getFavorites();
      emit(FavoritesLoaded(favorites: favorites));
    } catch (e) {
      emit(FavoritesError(message: 'Failed to load favorites: ${e.toString()}'));
    }
  }

  Future<void> _onAddToFavorites(
    AddToFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _localDataSource.addToFavorites(event.product);
      
      // Emit temporary state for feedback
      emit(FavoriteAdded(product: event.product));
      
      // Then reload favorites to show updated state
      add(LoadFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(message: 'Failed to add to favorites: ${e.toString()}'));
    }
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _localDataSource.removeFromFavorites(event.productId);
      
      // Emit temporary state for feedback
      emit(FavoriteRemoved(productId: event.productId));
      
      // Then reload favorites to show updated state
      add(LoadFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(message: 'Failed to remove from favorites: ${e.toString()}'));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final isFavorite = await _localDataSource.isFavorite(event.product.id);
      
      if (isFavorite) {
        await _localDataSource.removeFromFavorites(event.product.id);
        emit(FavoriteRemoved(productId: event.product.id));
      } else {
        await _localDataSource.addToFavorites(event.product);
        emit(FavoriteAdded(product: event.product));
      }
      
      // Then reload favorites to show updated state
      add(LoadFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(message: 'Failed to toggle favorite: ${e.toString()}'));
    }
  }

  Future<void> _onCheckIsFavorite(
    CheckIsFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      // If we have current loaded state, just check within it
      if (state is FavoritesLoaded) {
        final currentState = state as FavoritesLoaded;
        // Keep current state as it already has the info
        emit(FavoritesLoaded(favorites: currentState.favorites));
      } else {
        // Load favorites to check
        add(LoadFavoritesEvent());
      }
    } catch (e) {
      emit(FavoritesError(message: 'Failed to check favorite status: ${e.toString()}'));
    }
  }

  Future<void> _onClearFavorites(
    ClearFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _localDataSource.clearFavorites();
      emit(const FavoritesLoaded(favorites: []));
    } catch (e) {
      emit(FavoritesError(message: 'Failed to clear favorites: ${e.toString()}'));
    }
  }
}
