import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class GetOtherPlacesUseCase {
  final PlaceRepository repository;

  GetOtherPlacesUseCase(this.repository);

  Future<Result<PaginatedResponse<PlaceEntity>>> call({int page = 1}) {
    return repository.getPlaces(
      category: ['other'], // Assumed mock tag replacement for "Other Places"
      page: page,
    );
  }
}
