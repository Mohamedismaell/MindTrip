import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class ToggleTripFavoriteUseCase {
  final FavoritesRepository _repository;

  const ToggleTripFavoriteUseCase({required FavoritesRepository repository})
    : _repository = repository;

  Future<Result<void>> call({
    required String tripId,
    required bool isFavorite,
    FavoriteTripEntity? trip,
  }) {
    return _repository.toggleTripFavorite(
      tripId: tripId,
      isFavorite: isFavorite,
      trip: trip,
    );
  }
}
