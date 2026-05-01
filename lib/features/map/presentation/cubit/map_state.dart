import 'package:equatable/equatable.dart';
import '../../../../core/shared/data/models/place_model.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../../domain/entities/search_suggestion.dart';
import '../../domain/entities/map_route.dart';

class MapState extends Equatable {
  final List<MapAnnotationEntry> annotations;
  final PlaceModel? selectedPlace;
  final bool isBottomSheetVisible;
  
  final List<SearchSuggestion> searchSuggestions;
  final bool isSearchLoading;
  final String? searchError;
  
  final MapRoute? activeRoute;
  final bool isRouteLoading;
  final String? routeError;
  
  final bool isLocationGranted;

  const MapState({
    required this.annotations,
    this.selectedPlace,
    required this.isBottomSheetVisible,
    required this.searchSuggestions,
    required this.isSearchLoading,
    this.searchError,
    this.activeRoute,
    required this.isRouteLoading,
    this.routeError,
    required this.isLocationGranted,
  });

  factory MapState.initial() => const MapState(
    annotations: [],
    selectedPlace: null,
    isBottomSheetVisible: false,
    searchSuggestions: [],
    isSearchLoading: false,
    searchError: null,
    activeRoute: null,
    isRouteLoading: false,
    routeError: null,
    isLocationGranted: false,
  );

  MapState copyWith({
    List<MapAnnotationEntry>? annotations,
    PlaceModel? selectedPlace,
    bool? isBottomSheetVisible,
    List<SearchSuggestion>? searchSuggestions,
    bool? isSearchLoading,
    String? searchError,
    bool clearSearchError = false,
    MapRoute? activeRoute,
    bool? isRouteLoading,
    String? routeError,
    bool clearRouteError = false,
    bool clearActiveRoute = false,
    bool? isLocationGranted,
  }) {
    return MapState(
      annotations: annotations ?? this.annotations,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      isBottomSheetVisible: isBottomSheetVisible ?? this.isBottomSheetVisible,
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      searchError: clearSearchError ? null : (searchError ?? this.searchError),
      activeRoute: clearActiveRoute ? null : (activeRoute ?? this.activeRoute),
      isRouteLoading: isRouteLoading ?? this.isRouteLoading,
      routeError: clearRouteError ? null : (routeError ?? this.routeError),
      isLocationGranted: isLocationGranted ?? this.isLocationGranted,
    );
  }

  @override
  List<Object?> get props => [
    annotations,
    selectedPlace,
    isBottomSheetVisible,
    searchSuggestions,
    isSearchLoading,
    searchError,
    activeRoute,
    isRouteLoading,
    routeError,
    isLocationGranted,
  ];
}
