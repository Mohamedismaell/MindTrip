import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class GetFavoritePlacesUseCase {
  final FavoritesRepository repository;

  GetFavoritePlacesUseCase({required this.repository});

  Future<Result<List<PlaceEntity>>> call({
    required Set<String> placeIds,
  }) async {
    return await repository.getFavoritePlaces(placeIds: placeIds);
  }
}
