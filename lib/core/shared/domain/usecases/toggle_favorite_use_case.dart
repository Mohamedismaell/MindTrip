import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository _repository;

  const ToggleFavoriteUseCase({required FavoritesRepository repository})
    : _repository = repository;

  Future<Result<void>> call({
    required String placeId,
    required bool isFavorite,
    PlaceEntity? place,
  }) {
    return _repository.toggleFavorite(
      placeId: placeId,
      isFavorite: isFavorite,
      place: place,
    );
  }
}
