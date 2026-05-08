import 'package:equatable/equatable.dart';
import '../../../../core/shared/data/models/place_model.dart';
import '../../domain/entities/map_annotation_entry.dart';
import '../../domain/entities/google_place.dart';

class MapState extends Equatable {
  final List<MapAnnotationEntry> annotations;
  final PlaceModel? selectedPlace;
  final GooglePlaceEntity? selectedGooglePlace;
  final List<String> selectedPlacePhotoUrls;
  final bool isBottomSheetVisible;
  final bool isLocationGranted;
  final double? flyToLat;
  final double? flyToLng;

  const MapState({
    required this.annotations,
    this.selectedPlace,
    this.selectedGooglePlace,
    this.selectedPlacePhotoUrls = const [],
    required this.isBottomSheetVisible,
    required this.isLocationGranted,
    this.flyToLat,
    this.flyToLng,
  });

  factory MapState.initial() => const MapState(
        annotations: [],
        selectedPlace: null,
        selectedGooglePlace: null,
        selectedPlacePhotoUrls: [],
        isBottomSheetVisible: false,
        isLocationGranted: false,
        flyToLat: null,
        flyToLng: null,
      );

  MapState copyWith({
    List<MapAnnotationEntry>? annotations,
    PlaceModel? selectedPlace,
    bool clearSelectedPlace = false,
    GooglePlaceEntity? selectedGooglePlace,
    bool clearSelectedGooglePlace = false,
    List<String>? selectedPlacePhotoUrls,
    bool? isBottomSheetVisible,
    bool? isLocationGranted,
    double? flyToLat,
    double? flyToLng,
    bool clearFlyToLocation = false,
  }) {
    return MapState(
      annotations: annotations ?? this.annotations,
      selectedPlace: clearSelectedPlace
          ? null
          : (selectedPlace ?? this.selectedPlace),
      selectedGooglePlace: clearSelectedGooglePlace
          ? null
          : (selectedGooglePlace ?? this.selectedGooglePlace),
      selectedPlacePhotoUrls:
          selectedPlacePhotoUrls ?? this.selectedPlacePhotoUrls,
      isBottomSheetVisible: isBottomSheetVisible ?? this.isBottomSheetVisible,
      isLocationGranted: isLocationGranted ?? this.isLocationGranted,
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
        isLocationGranted,
        flyToLat,
        flyToLng,
      ];
}
