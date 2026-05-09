import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/map/data/models/place_prediction.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';

abstract class GooglePlacesRepository {
  Future<Result<List<PlacePrediction>>> findAutocompletePredictions(
    String query, {
    double? lat,
    double? lng,
    CancelToken? cancelToken,
  });

  Future<Result<GooglePlaceEntity>> fetchPlaceDetails(
    String placeId, {
    CancelToken? cancelToken,
  });

  Future<Result<List<String>>> fetchPlacePhotoUrls(
    List<dynamic> photos, {
    int maxWidth,
    CancelToken? cancelToken,
  });

  Future<Result<List<GooglePlaceEntity>>> nearbySearch(
    double lat,
    double lng,
    double radiusMeters, {
    List<String>? includedTypes,
    CancelToken? cancelToken,
  });
}
