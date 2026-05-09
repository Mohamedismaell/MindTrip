import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/domain/repositories/google_places_repository.dart';

class NearbySearchUseCase {
  final GooglePlacesRepository repository;

  NearbySearchUseCase({required this.repository});

  Future<Result<List<GooglePlaceEntity>>> call(
    double lat,
    double lng,
    double radiusMeters, {
    List<String>? includedTypes,
    CancelToken? cancelToken,
  }) {
    return repository.nearbySearch(
      lat,
      lng,
      radiusMeters,
      includedTypes: includedTypes,
      cancelToken: cancelToken,
    );
  }
}
