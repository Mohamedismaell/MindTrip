import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/shared/data/datasources/places_local_data_source.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/mapper/place_mapper.dart';
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
      final remote = await _remote.getPlaceDetails(placeId);
      await _local.cachePlace(remote);
      return Result.ok(remote.toEntity());
    } catch (e) {
      try {
        final local = await _local.getPlace(placeId);
        if (local != null) {
          return Result.ok(local.toEntity());
        }
      } catch (_) {}
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> getNearbyPlaces(
    String placeId, {
    int page = 1,
    int limit = 10,
    double? lat,
    double? lng,
  }) async {
    try {
      final remote = await _remote.getNearbyPlaces(
        placeId,
        page: page,
        limit: limit,
        lat: lat,
        lng: lng,
      );
      return Result.ok(remote.map((m) => m.toEntity()));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
