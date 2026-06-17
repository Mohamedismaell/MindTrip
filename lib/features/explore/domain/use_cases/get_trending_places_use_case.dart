import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class GetTrendingPlacesUseCase {
  final PlaceRepository repository;

  GetTrendingPlacesUseCase(this.repository);

  Future<Result<PaginatedResponse<PlaceEntity>>> call({int page = 1}) {
    // If backend doesn't support trending specifically, maybe "hidden_gem: false" or sort_by="rating"
    return repository.getPlaces(
      sortBy: 'rating',
      order: 'desc',
      page: page,
    );
  }
}
