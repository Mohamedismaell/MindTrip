import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/places/data/datasources/place_local_data_source.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/data/mapper/place_mapper.dart';
import 'package:mindtrip/features/places/data/models/nearby_places_request_model.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/place_details/data/datasources/place_details_remote_data_source.dart';
import 'package:mindtrip/features/place_details/domain/repositories/place_details_repository.dart';

class PlaceDetailsRepositoryImpl implements PlaceDetailsRepository {
  final PlaceDetailsRemoteDataSource _remote;
  final PlaceLocalDataSource _local;

  PlaceDetailsRepositoryImpl({
    required PlaceDetailsRemoteDataSource remote,
    required PlaceLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  @override
  Future<Result<PlaceEntity>> getPlaceDetails(String placeId) async {
    try {
      final remote = await _remote.getPlaceDetails(placeId);
      await _local.cachePlace(remote);
      return Result.ok(remote.toEntity());
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return _getPlaceDetailsLocalFallback(placeId, e);
    } catch (e) {
      return _getPlaceDetailsLocalFallback(placeId, e);
    }
  }

  Future<Result<PlaceEntity>> _getPlaceDetailsLocalFallback(
    String placeId,
    Object e,
  ) async {
    try {
      final local = await _local.getPlace(placeId);
      if (local != null) {
        return Result.ok(local.toEntity());
      }
    } catch (_) {}
    return Result.error(ApiErrorMapper.fromException(e));
  }

  @override
  Future<Result<PaginatedResponse<PlaceEntity>>> getNearbyPlaces({
    required NearbyPlacesRequestModel request,
  }) async {
    try {
      final remote = await _remote.getNearbyPlaces(request: request);
      return Result.ok(remote.map((m) => m.toEntity()));
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
