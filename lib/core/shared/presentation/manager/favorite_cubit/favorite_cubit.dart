import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/usecases/get_favorites_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/sync_favorites_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/toggle_favorite_use_case.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetFavoritesUseCase _getFavoritesUseCase;
  final SyncFavoritesUseCase _syncFavoritesUseCase;

  FavoriteCubit({
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required GetFavoritesUseCase getFavoritesUseCase,
    required SyncFavoritesUseCase syncFavoritesUseCase,
  }) : _toggleFavoriteUseCase = toggleFavoriteUseCase,
       _getFavoritesUseCase = getFavoritesUseCase,
       _syncFavoritesUseCase = syncFavoritesUseCase,
       super(const FavoriteState()) {
    loadFavorites();
  }

  Future<void> toggleFavorite({
    required String placeId,
    required bool isFavorite,
  }) async {
    final updatedFavorites = Set<String>.from(state.favoriteIds);
    if (isFavorite) {
      updatedFavorites.add(placeId);
      print('added $placeId');
    } else {
      updatedFavorites.remove(placeId);
      print('removed $placeId');
    }

    emit(
      state.copyWith(
        favoriteIds: updatedFavorites,
        status: FavoritesStatus.syncing,
      ),
    );
    print('favoriteIds ===> ${state.favoriteIds}');
    final result = await _toggleFavoriteUseCase.call(
      placeId: placeId,
      isFavorite: isFavorite,
    );

    result.when(
      success: (_) {
        emit(state.copyWith(status: FavoritesStatus.loaded));
      },
      failure: (error) {
        emit(state.copyWith(status: FavoritesStatus.loaded));
      },
    );
  }

  Future<void> loadFavorites() async {
    print('fovorites loaded ===>');
    final result = await _getFavoritesUseCase.call();
    result.when(
      success: (favoriteIds) {
        print('fovorites loaded ===> $favoriteIds');
        emit(
          state.copyWith(
            favoriteIds: favoriteIds,
            status: FavoritesStatus.loaded,
          ),
        );
      },
      failure: (_) {
        emit(state.copyWith(status: FavoritesStatus.error));
      },
    );
  }

  Future<void> syncPendingFavorites() async {
    emit(state.copyWith(status: FavoritesStatus.syncing));

    final result = await _syncFavoritesUseCase.call();

    result.when(
      success: (_) {
        emit(state.copyWith(status: FavoritesStatus.loaded));
      },
      failure: (_) {
        emit(state.copyWith(status: FavoritesStatus.loaded));
      },
    );
  }

  bool isFavorite(String placeId) {
    return state.favoriteIds.contains(placeId);
  }

  void clear() {
    emit(const FavoriteState());
  }
}
