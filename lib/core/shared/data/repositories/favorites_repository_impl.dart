import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/shared/data/datasources/favorites_local_data_source.dart';
import 'package:mindtrip/core/shared/data/datasources/favorites_remote_data_source.dart';
import 'package:mindtrip/core/shared/data/models/favorite_trip_model.dart';
import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';
import 'package:mindtrip/features/places/data/datasources/place_local_data_source.dart';
import 'package:mindtrip/features/places/data/mapper/place_mapper.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _local;
  final FavoritesRemoteDataSource _remote;
  final PlaceLocalDataSource _placesLocal;

  FavoritesRepositoryImpl({
    required FavoritesLocalDataSource local,
    required FavoritesRemoteDataSource remote,
    required PlaceLocalDataSource placesLocal,
  }) : _local = local,
       _remote = remote,
       _placesLocal = placesLocal;

  @override
  Future<Result<void>> bootstrapFromServer() async {
    try {
      final serverFavorites = await _remote.getFavoritePlacesFromServer();
      await _local.replaceAllPlaces(
        serverFavorites.map((e) => e.place).toList(),
      );
      return Result.ok(null);
    } catch (e) {
      // Silent failure
      return Result.ok(null);
    }
  }

  @override
  Future<Result<void>> bootstrapFavoriteTripsFromServer() async {
    try {
      final serverFavorites = await _remote.getFavoriteTripsFromServer();
      await _local.replaceAllTrips(serverFavorites);
      return Result.ok(null);
    } catch (e) {
      // Silent failure
      return Result.ok(null);
    }
  }

  @override
  Future<Result<void>> syncPendingFavorites() async {
    try {
      final pendingActions = await _local.getPendingSyncActions();

      for (final entry in pendingActions.entries) {
        final placeId = entry.key;
        final action = entry.value;

        try {
          if (action == 'add') {
            await _remote.addFavoriteId(placeId: placeId);
          } else if (action == 'remove') {
            await _remote.deleteFavoriteIds(placeId: placeId);
          }
          // If successful ===> remove from queue
          await _local.removeSyncAction(placeId: placeId);
        } catch (e) {
          //* will not stop the whole sync operation for now
          //* keeping trying the SYNC
        }
      }

      return Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> syncPendingTripFavorites() async {
    try {
      final pendingActions = await _local.getPendingTripSyncActions();

      for (final entry in pendingActions.entries) {
        final tripId = entry.key;
        final action = entry.value;

        try {
          if (action == 'add') {
            final remoteTrip = await _remote.addFavoriteTrip(tripId: tripId);
            await _local.addFavoriteTrip(trip: remoteTrip);
          } else if (action == 'remove') {
            await _remote.deleteFavoriteTrip(tripId: tripId);
          }
          await _local.removeTripSyncAction(tripId: tripId);
        } catch (e) {
          //* will not stop the whole sync operation for now
          //* keeping trying the SYNC
        }
      }

      return Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> toggleFavorite({
    required String placeId,
    required bool isFavorite,
    PlaceEntity? place,
  }) async {
    try {
      if (isFavorite) {
        if (place != null) {
          // If the UI provided the entity
          await _local.addFavoritePlace(place: place.toModel());
        } else {
          // PlaceModel from the shared places cache
          final cachedPlace = await _placesLocal.getPlace(placeId);
          if (cachedPlace != null) {
            await _local.addFavoritePlace(place: cachedPlace);
          }
        }
      } else {
        await _local.removeFavoritePlace(placeId: placeId);
      }

      try {
        if (isFavorite) {
          await _remote.addFavoriteId(placeId: placeId);
        } else {
          await _remote.deleteFavoriteIds(placeId: placeId);
        }
        await _local.removeSyncAction(placeId: placeId);
      } catch (e) {
        //* If remote fails ===> enqueue for later
        final action = isFavorite ? 'add' : 'remove';
        await _local.enqueueSyncAction(placeId: placeId, action: action);
      }

      return Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> toggleTripFavorite({
    required String tripId,
    required bool isFavorite,
    FavoriteTripEntity? trip,
  }) async {
    try {
      if (isFavorite) {
        if (trip != null) {
          await _local.addFavoriteTrip(trip: trip.toModel());
        }
      } else {
        await _local.removeFavoriteTrip(tripId: tripId);
      }

      try {
        if (isFavorite) {
          final remoteTrip = await _remote.addFavoriteTrip(tripId: tripId);
          await _local.addFavoriteTrip(trip: remoteTrip);
        } else {
          await _remote.deleteFavoriteTrip(tripId: tripId);
        }
        await _local.removeTripSyncAction(tripId: tripId);
      } catch (e) {
        final action = isFavorite ? 'add' : 'remove';
        await _local.enqueueTripSyncAction(tripId: tripId, action: action);
      }

      return Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> clearAll() async {
    try {
      await _local.clearAll();
      return Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<PlaceEntity>>> getFavoritePlacesLocal() async {
    try {
      final localFavorites = await _local.getAllFavoritePlaces();
      return Result.ok(localFavorites.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<FavoriteTripEntity>>> getFavoriteTripsLocal() async {
    try {
      final localFavorites = await _local.getAllFavoriteTrips();
      return Result.ok(localFavorites.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
