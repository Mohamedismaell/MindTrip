import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/shared/data/datasources/favorites_local_data_source.dart';
import 'package:mindtrip/core/shared/data/datasources/favorites_remote_data_source.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _local;
  final FavoritesRemoteDataSource _remote;

  FavoritesRepositoryImpl({
    required FavoritesLocalDataSource local,
    required FavoritesRemoteDataSource remote,
  }) : _local = local,
       _remote = remote;

  //Todo: Later Handle api call for remote
  @override
  Future<Result<Set<String>>> getFavoriteIds() async {
    try {
      final result = await _local.getFavoriteIds();
      return Result.ok(result);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
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
  Future<Result<void>> toggleFavorite({
    required String placeId,
    required bool isFavorite,
  }) async {
    try {
      if (isFavorite) {
        await _local.addFavoriteIds(placeId: placeId);
      } else {
        await _local.removeFavoriteIds(placeId: placeId);
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
  Future<Result<void>> clearAll() async {
    try {
      await _local.clearAll();
      await _remote.clearAll();
      return Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
