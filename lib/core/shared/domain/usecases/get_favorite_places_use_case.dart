import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class GetFavoritePlacesUseCase {
  final FavoritesRepository repository;

  GetFavoritePlacesUseCase({required this.repository});

  Future<Result<List<PlaceModel>>> call({required Set<String> placeIds}) async {
    return await repository.getFavoritePlaces(placeIds: placeIds);
  }
}
