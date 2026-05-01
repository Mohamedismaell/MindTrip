import 'package:mapbox_search/mapbox_search.dart';
import '../../domain/entities/search_suggestion.dart' as domain;
import '../../domain/entities/map_search_result.dart';

class MapSearchRemoteDatasource {
  final SearchBoxAPI _searchBoxAPI;

  MapSearchRemoteDatasource() : _searchBoxAPI = SearchBoxAPI();
  //! I think we need to take mroe values from the SearchSuggestion mdoel sdk
  Future<List<domain.SearchSuggestion>> suggest(String query) async {
    final response = await _searchBoxAPI.getSuggestions(query);

    return response.fold(
      (success) => success.suggestions.map((s) {
        return domain.SearchSuggestion(
          mapboxId: s.mapboxId,
          name: s.name,
          fullAddress: s.fullAddress ?? s.placeFormatted,
        );
      }).toList(),
      (failure) => throw Exception(failure.message),
    );
  }

  Future<MapSearchResult> retrieve(String mapboxId) async {
    final response = await _searchBoxAPI.getPlace(mapboxId);

    return response.fold((success) {
      if (success.features.isEmpty) {
        throw Exception('No features returned for mapboxId: $mapboxId');
      }
      final feature = success.features.first;
      // geometry.coordinates is the canonical lat/lng for a place
      final coords = feature.geometry.coordinates;
      return MapSearchResult(
        name: feature.properties.name,
        latitude: coords.lat,
        longitude: coords.long,
        address:
            feature.properties.fullAddress ?? feature.properties.placeFormatted,
      );
    }, (failure) => throw Exception(failure.message));
  }
}
