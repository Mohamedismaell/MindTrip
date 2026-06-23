import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

part 'favorite_state.freezed.dart';

enum FavoritesStatus { initial, loading, loaded, empty, error, syncing }

@freezed
abstract class FavoriteState with _$FavoriteState {
  const FavoriteState._();

  const factory FavoriteState({
    @Default(<String>{}) Set<String> favoriteIds,
    @Default(<PlaceEntity>[]) List<PlaceEntity> favoritePlaces,
    @Default(FavoritesStatus.initial) FavoritesStatus status,
    String? errorMessage,
    @Default(PlaceCategory.all) PlaceCategory selectedCategory,
  }) = _FavoriteState;

  List<PlaceEntity> get filteredPlaces {
    if (selectedCategory == PlaceCategory.all) {
      return favoritePlaces;
    }

    return favoritePlaces
        .where((place) => place.category == selectedCategory)
        .toList();
  }
}
