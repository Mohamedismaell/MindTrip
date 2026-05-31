import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/place_details/domain/repositories/place_details_repository.dart';

class GetPlaceDetailsUseCase {
  final PlaceDetailsRepository repository;

  GetPlaceDetailsUseCase({required this.repository});

  Future<Result<PlaceModel>> call(String placeId) =>
      repository.getPlaceDetails(placeId);
}
