import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/domain/usecases/bootstrap_favorites_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/get_favorite_places_localuse_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/sync_favorites_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/toggle_favorite_use_case.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_state.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

class FavoriteCubit extends SafeCubit<FavoriteState> {
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetFavoritePlacesLocalUseCase _getFavoritePlacesLocalUseCase;
  final SyncFavoritesUseCase _syncFavoritesUseCase;
  final BootstrapFavoritesUseCase _bootstrapFavoritesUseCase;

  FavoriteCubit({
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required GetFavoritePlacesLocalUseCase getFavoritePlacesUseCase,
    required SyncFavoritesUseCase syncFavoritesUseCase,
    required BootstrapFavoritesUseCase bootstrapFavoritesUseCase,
  }) : _toggleFavoriteUseCase = toggleFavoriteUseCase,
       _getFavoritePlacesLocalUseCase = getFavoritePlacesUseCase,
       _syncFavoritesUseCase = syncFavoritesUseCase,
       _bootstrapFavoritesUseCase = bootstrapFavoritesUseCase,
       super(const FavoriteState());

  Future<void> loadFavorites() async {
    emitSafe(state.copyWith(status: FavoritesStatus.loading));

    await _bootstrapFavoritesUseCase.call();

    final result = await _getFavoritePlacesLocalUseCase.call();
    result.when(
      success: (places) {
        final ids = places.map((p) => p.id).toSet();
        emitSafe(
          state.copyWith(
            favoriteIds: ids,
            favoritePlaces: places,
            status: places.isEmpty
                ? FavoritesStatus.empty
                : FavoritesStatus.loaded,
          ),
        );
      },
      failure: (_) {
        emitSafe(state.copyWith(status: FavoritesStatus.error));
      },
      cancelled: () {},
    );
  }

  Future<void> toggleFavorite({
    required String placeId,
    required bool isFavorite,
    PlaceEntity? place,
  }) async {
    // Optimistic update
    final updatedIds = Set<String>.from(state.favoriteIds);
    List<PlaceEntity> updatedPlaces = List.from(state.favoritePlaces);
    if (isFavorite) {
      updatedIds.add(placeId);
      if (place != null && !updatedPlaces.any((p) => p.id == placeId)) {
        updatedPlaces = [...updatedPlaces, place];
      }
    } else {
      updatedIds.remove(placeId);
      updatedPlaces = updatedPlaces.where((p) => p.id != placeId).toList();
    }

    emitSafe(
      state.copyWith(
        favoriteIds: updatedIds,
        favoritePlaces: updatedPlaces,
        status: FavoritesStatus.syncing,
      ),
    );

    await _toggleFavoriteUseCase.call(
      placeId: placeId,
      isFavorite: isFavorite,
      place: place,
    );

    emitSafe(
      state.copyWith(
        status: updatedIds.isEmpty
            ? FavoritesStatus.empty
            : FavoritesStatus.loaded,
      ),
    );
  }

  void selectCategory(PlaceCategory category) {
    emitSafe(state.copyWith(selectedCategory: category));
  }

  Future<void> syncPendingFavorites() async {
    await _syncFavoritesUseCase.call();
  }

  bool isFavorite(String placeId) => state.favoriteIds.contains(placeId);

  void clear() => emitSafe(const FavoriteState());
}
