import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/map/data/models/place_prediction.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/domain/repositories/google_places_repository.dart';
import 'package:mindtrip/features/map/data/datasources/google_places_datasource.dart';
import 'package:mindtrip/features/map/data/mapper/google_mapper.dart';

class GooglePlacesRepositoryImpl implements GooglePlacesRepository {
  final GooglePlacesRemoteDatasource _datasource;

  GooglePlacesRepositoryImpl({required GooglePlacesRemoteDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Result<List<PlacePrediction>>> findAutocompletePredictions(
    String query, {
    double? lat,
    double? lng,
  }) async {
    try {
      final result = await _datasource.findAutocompletePredictions(
        query,
        lat: lat,
        lng: lng,
      );
      return Result.ok(result);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<GooglePlaceEntity>> fetchPlaceDetails(String placeId) async {
    try {
      final result = await _datasource.fetchPlaceDetails(placeId);
      return Result.ok(result.toEntity());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<String>>> fetchPlacePhotoUrls(
    List<dynamic> photos, {
    int maxWidth = 800,
  }) async {
    try {
      final urls = photos.map((photo) {
        final ref = photo.photoReference as String;
        return _datasource.buildPhotoUrl(ref, maxWidth: maxWidth);
      }).toList();
      return Result.ok(urls);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<List<GooglePlaceEntity>>> nearbySearch(
    double lat,
    double lng,
    double radiusMeters, {
    List<String>? includedTypes,
  }) async {
    try {
      final result = await _datasource.nearbySearch(
        lat,
        lng,
        radiusMeters,
        includedTypes: includedTypes,
      );
      return Result.ok(result.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
