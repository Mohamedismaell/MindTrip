import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';

abstract class FavoritesRepository {
  Future<Result<void>> bootstrapFromServer();
  Future<Result<void>> toggleFavorite({
    required String placeId,
    required bool isFavorite,
    PlaceEntity? place,
  });
  Future<Result<void>> syncPendingFavorites();
  Future<Result<void>> clearAll();
  Future<Result<List<PlaceEntity>>> getFavoritePlacesLocal();

  Future<Result<void>> bootstrapFavoriteTripsFromServer();
  Future<Result<void>> toggleTripFavorite({
    required String tripId,
    required bool isFavorite,
    FavoriteTripEntity? trip,
  });
  Future<Result<void>> syncPendingTripFavorites();
  Future<Result<List<FavoriteTripEntity>>> getFavoriteTripsLocal();
}
