import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/domain/usecases/get_favorite_places_use_case.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_cubit.dart';

part 'saved_places_state.dart';

class SavedPlacesCubit extends Cubit<FavoritesScreenState> {
  final GetFavoritePlacesUseCase _getFavoritePlacesUseCase;
  final FavoriteCubit _favoriteCubit;
  StreamSubscription<FavoriteState>? _favoriteSubscription;

  SavedPlacesCubit({
    required GetFavoritePlacesUseCase getFavoritePlacesUseCase,
    required FavoriteCubit favoriteCubit,
  }) : _getFavoritePlacesUseCase = getFavoritePlacesUseCase,
       _favoriteCubit = favoriteCubit,
       super(const FavoritesScreenState()) {
    _listenToFavoriteChanges();
  }

  Future<void> loadFavoritePlaces() async {
    final favoriteIds = _favoriteCubit.state.favoriteIds;

    if (favoriteIds.isEmpty) {
      print('favoriteIds isEmpty');
      emit(state.copyWith(places: [], placesStatus: FavoritesTabStatus.empty));
      return;
    }

    emit(state.copyWith(placesStatus: FavoritesTabStatus.loading));

    final result = await _getFavoritePlacesUseCase.call(placeIds: favoriteIds);

    result.when(
      success: (places) {
        emit(
          state.copyWith(
            places: places,
            placesStatus: places.isEmpty
                ? FavoritesTabStatus.empty
                : FavoritesTabStatus.loaded,
          ),
        );
        print('favorites loaded ===> $places');
      },
      failure: (error) {
        print('favorites error ===> ${error.message}');
        emit(
          state.copyWith(
            placesStatus: FavoritesTabStatus.error,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  // Update the selected category filter.
  void selectCategory(PlaceCategory category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void _listenToFavoriteChanges() {
    _favoriteSubscription = _favoriteCubit.stream.listen((favoriteState) {
      final currentIds = favoriteState.favoriteIds;

      if (state.placesStatus == FavoritesTabStatus.initial) {
        return;
      }
      final hasNewIds = currentIds.any(
        (id) => !state.places.any((p) => p.id == id),
      );

      //! Recheck later
      if (hasNewIds) {
        loadFavoritePlaces();
      } else {
        final updatedPlaces = state.places
            .where((p) => currentIds.contains(p.id))
            .toList();

        if (updatedPlaces.length != state.places.length) {
          emit(
            state.copyWith(
              places: updatedPlaces,
              placesStatus: updatedPlaces.isEmpty
                  ? FavoritesTabStatus.empty
                  : FavoritesTabStatus.loaded,
            ),
          );
        }
      }
    });
  }

  @override
  Future<void> close() {
    _favoriteSubscription?.cancel();
    return super.close();
  }
}
