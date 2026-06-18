import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/place_details/domain/repositories/place_details_repository.dart';

class GetPlaceDetailsUseCase {
  final PlaceDetailsRepository repository;

  GetPlaceDetailsUseCase({required this.repository});

  Future<Result<PlaceEntity>> call(String placeId) =>
      repository.getPlaceDetails(placeId);
}
