import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/place_details/domain/repositories/place_details_repository.dart';

class GetNearbyPlacesUseCase {
  final PlaceDetailsRepository repository;

  GetNearbyPlacesUseCase({required this.repository});

  Future<Result<List<PlaceModel>>> call(
    String placeId, {
    double? lat,
    double? lng,
  }) =>
      repository.getNearbyPlaces(placeId, lat: lat, lng: lng);
}
