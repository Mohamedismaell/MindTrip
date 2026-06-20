import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/search/data/models/search_places_request_model.dart';

abstract class SearchRemoteDataSource {
  Future<PaginatedResponse<PlaceModel>> searchPlaces({
    required SearchPlacesRequestModel request,
    CancelToken? cancelToken,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiConsumer _api;

  SearchRemoteDataSourceImpl({required ApiConsumer api}) : _api = api;

  @override
  Future<PaginatedResponse<PlaceModel>> searchPlaces({
    required SearchPlacesRequestModel request,
    CancelToken? cancelToken,
  }) async {
    final response = await _api.post(
      EndPoints.searchPlaces,
      data: request.toJson(),
      cancelToken: cancelToken,
    );

    return PaginatedResponse<PlaceModel>.fromJson(
      response,
      (json) => PlaceModel.fromJson(json),
    );
  }
}
