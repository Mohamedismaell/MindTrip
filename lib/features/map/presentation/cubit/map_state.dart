import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/map/data/models/place_prediction.dart';
import '../../../../core/shared/data/models/place_model.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../../domain/entities/google_place.dart';
import '../../domain/entities/map_route.dart';

class MapState extends Equatable {
  final List<MapAnnotationEntry> annotations;
  final PlaceModel? selectedPlace;
  final GooglePlaceEntity? selectedGooglePlace;
  final List<String> selectedPlacePhotoUrls;
  final bool isBottomSheetVisible;
  final List<PlacePrediction> autocompletePredictions;
  final bool isSearchLoading;
  final String? searchError;
  final MapRoute? activeRoute;
  final bool isRouteLoading;
  final String? routeError;
  final bool isLocationGranted;
  final GooglePlaceEntity? resolvedSearchPlace;
  final List<GooglePlaceEntity> nearbyPlaces;
  final double? flyToLat;
  final double? flyToLng;

  const MapState({
    required this.annotations,
    this.selectedPlace,
    this.selectedGooglePlace,
    this.selectedPlacePhotoUrls = const [],
    required this.isBottomSheetVisible,
    required this.autocompletePredictions,
    required this.isSearchLoading,
    this.searchError,
    this.activeRoute,
    required this.isRouteLoading,
    this.routeError,
    required this.isLocationGranted,
    this.resolvedSearchPlace,
    this.nearbyPlaces = const [],
    this.flyToLat,
    this.flyToLng,
  });

  factory MapState.initial() => const MapState(
    annotations: [],
    selectedPlace: null,
    selectedGooglePlace: null,
    selectedPlacePhotoUrls: [],
    isBottomSheetVisible: false,
    autocompletePredictions: [],
    isSearchLoading: false,
    searchError: null,
    activeRoute: null,
    isRouteLoading: false,
    routeError: null,
    isLocationGranted: false,
    resolvedSearchPlace: null,
    nearbyPlaces: [],
    flyToLat: null,
    flyToLng: null,
  );

  MapState copyWith({
    List<MapAnnotationEntry>? annotations,
    PlaceModel? selectedPlace,
    GooglePlaceEntity? selectedGooglePlace,
    bool clearSelectedGooglePlace = false,
    List<String>? selectedPlacePhotoUrls,
    bool? isBottomSheetVisible,
    List<PlacePrediction>? autocompletePredictions,
    bool? isSearchLoading,
    String? searchError,
    bool clearSearchError = false,
    MapRoute? activeRoute,
    bool? isRouteLoading,
    String? routeError,
    bool clearRouteError = false,
    bool clearActiveRoute = false,
    bool? isLocationGranted,
    GooglePlaceEntity? resolvedSearchPlace,
    bool clearResolvedSearchPlace = false,
    List<GooglePlaceEntity>? nearbyPlaces,
    double? flyToLat,
    double? flyToLng,
    bool clearFlyToLocation = false,
  }) {
    return MapState(
      annotations: annotations ?? this.annotations,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      selectedGooglePlace: clearSelectedGooglePlace
          ? null
          : (selectedGooglePlace ?? this.selectedGooglePlace),
      selectedPlacePhotoUrls:
          selectedPlacePhotoUrls ?? this.selectedPlacePhotoUrls,
      isBottomSheetVisible: isBottomSheetVisible ?? this.isBottomSheetVisible,
      autocompletePredictions:
          autocompletePredictions ?? this.autocompletePredictions,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      searchError: clearSearchError ? null : (searchError ?? this.searchError),
      activeRoute: clearActiveRoute ? null : (activeRoute ?? this.activeRoute),
      isRouteLoading: isRouteLoading ?? this.isRouteLoading,
      routeError: clearRouteError ? null : (routeError ?? this.routeError),
      isLocationGranted: isLocationGranted ?? this.isLocationGranted,
      resolvedSearchPlace: clearResolvedSearchPlace
          ? null
          : (resolvedSearchPlace ?? this.resolvedSearchPlace),
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      flyToLat: clearFlyToLocation ? null : (flyToLat ?? this.flyToLat),
      flyToLng: clearFlyToLocation ? null : (flyToLng ?? this.flyToLng),
    );
  }

  @override
  List<Object?> get props => [
    annotations,
    selectedPlace,
    selectedGooglePlace,
    selectedPlacePhotoUrls,
    isBottomSheetVisible,
    autocompletePredictions,
    isSearchLoading,
    searchError,
    activeRoute,
    isRouteLoading,
    routeError,
    isLocationGranted,
    resolvedSearchPlace,
    nearbyPlaces,
    flyToLat,
    flyToLng,
  ];
}
