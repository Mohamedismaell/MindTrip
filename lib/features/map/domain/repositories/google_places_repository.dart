import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/map/data/models/place_prediction.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';

abstract class GooglePlacesRepository {
  Future<Result<List<PlacePrediction>>> findAutocompletePredictions(
    String query, {
    double? lat,
    double? lng,
  });

  Future<Result<GooglePlaceEntity>> fetchPlaceDetails(String placeId);

  /// Returns a list of photo URLs for a place
  Future<Result<List<String>>> fetchPlacePhotoUrls(
    List<dynamic> photos, {
    int maxWidth,
  });

  Future<Result<List<GooglePlaceEntity>>> nearbySearch(
    double lat,
    double lng,
    double radiusMeters, {
    List<String>? includedTypes,
  });
}
