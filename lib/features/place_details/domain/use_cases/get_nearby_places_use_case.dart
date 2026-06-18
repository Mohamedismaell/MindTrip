import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/place_details/domain/repositories/place_details_repository.dart';

class GetNearbyPlacesUseCase {
  final PlaceDetailsRepository repository;

  GetNearbyPlacesUseCase({required this.repository});

  Future<Result<List<PlaceEntity>>> call(
    String placeId, {
    double? lat,
    double? lng,
  }) => repository.getNearbyPlaces(placeId, lat: lat, lng: lng);
}
