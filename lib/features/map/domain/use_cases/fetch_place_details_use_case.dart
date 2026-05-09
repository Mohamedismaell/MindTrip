import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/domain/repositories/google_places_repository.dart';

class FetchPlaceDetailsUseCase {
  final GooglePlacesRepository repository;

  FetchPlaceDetailsUseCase({required this.repository});

  Future<Result<GooglePlaceEntity>> call(
    String placeId, {
    CancelToken? cancelToken,
  }) {
    return repository.fetchPlaceDetails(
      placeId,
      cancelToken: cancelToken,
    );
  }
}
