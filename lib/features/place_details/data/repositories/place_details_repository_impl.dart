import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/shared/data/datasources/places_local_data_source.dart';
import 'package:mindtrip/core/shared/data/mapper/place_mapper.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/place_details/data/datasources/place_details_remote_data_source.dart';
import 'package:mindtrip/features/place_details/domain/repositories/place_details_repository.dart';

class PlaceDetailsRepositoryImpl implements PlaceDetailsRepository {
  final PlaceDetailsRemoteDataSource _remote;
  final PlacesLocalDataSource _local;

  PlaceDetailsRepositoryImpl({
    required PlaceDetailsRemoteDataSource remote,
    required PlacesLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  @override
  Future<Result<PlaceEntity>> getPlaceDetails(String placeId) async {
    try {
      final cached = await _local.getPlace(placeId);
      if (cached != null) {
        return Result.ok(cached.toEntity());
      }

      final remote = await _remote.getPlaceDetails(placeId);
      await _local.cachePlace(remote);
      return Result.ok(remote.toEntity());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<PlaceEntity>>> getNearbyPlaces(
    String placeId, {
    double? lat,
    double? lng,
  }) async {
    try {
      final remote = await _remote.getNearbyPlaces(placeId, lat: lat, lng: lng);
      //! maybe cache nearby places if we want
      // await _local.cachePlaces(remote);
      return Result.ok(remote.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
