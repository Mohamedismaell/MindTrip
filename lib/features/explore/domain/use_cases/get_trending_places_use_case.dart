import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class GetTrendingPlacesUseCase {
  final PlaceRepository repository;

  GetTrendingPlacesUseCase(this.repository);

  Future<Result<List<PlaceEntity>>> call() {
    return repository.getTrendingPlaces();
  }
}
