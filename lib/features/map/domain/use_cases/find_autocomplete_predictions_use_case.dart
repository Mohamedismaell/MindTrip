import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/map/data/models/place_prediction.dart';
import 'package:mindtrip/features/map/domain/repositories/google_places_repository.dart';

class FindAutocompletePredictionsUseCase {
  final GooglePlacesRepository repository;

  FindAutocompletePredictionsUseCase({required this.repository});

  Future<Result<List<PlacePrediction>>> call(
    String query, {
    double? lat,
    double? lng,
    CancelToken? cancelToken,
  }) {
    return repository.findAutocompletePredictions(
      query,
      lat: lat,
      lng: lng,
      cancelToken: cancelToken,
    );
  }
}
