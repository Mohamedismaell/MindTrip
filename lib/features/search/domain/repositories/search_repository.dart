import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/search/data/models/search_places_request_model.dart';
import 'package:mindtrip/features/search/domain/entity/recent_search_entity.dart';

abstract class SearchRepository {
  Future<Result<PaginatedResponse<PlaceEntity>>> searchPlaces({
    required SearchPlacesRequestModel request,
    CancelToken? cancelToken,
  });

  Future<Result<List<RecentSearchEntity>>> getRecentSearches();
  Future<Result<void>> saveRecentSearch(RecentSearchEntity query);
  Future<Result<void>> clearRecentSearches();
}
