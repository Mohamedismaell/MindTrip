import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/map/domain/repositories/google_places_repository.dart';

class FetchPlacePhotoUrlsUseCase {
  final GooglePlacesRepository repository;

  FetchPlacePhotoUrlsUseCase({required this.repository});

  Future<Result<List<String>>> call(
    List<dynamic> photos, {
    int maxWidth = 800,
    CancelToken? cancelToken,
  }) {
    return repository.fetchPlacePhotoUrls(
      photos,
      maxWidth: maxWidth,
      cancelToken: cancelToken,
    );
  }
}
