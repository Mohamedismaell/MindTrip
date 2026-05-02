import 'package:equatable/equatable.dart';

class MapSearchResult extends Equatable {
  final String mapboxId;
  final String name;
  final double latitude;
  final double longitude;
  final String? address;
  final String? fullAddress;
  final String? placeFormatted;
  final String? featureType;
  final String? maki;
  final List<String>? poiCategory;
  final String? countryName;
  final String? regionName;

  const MapSearchResult({
    required this.mapboxId,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.address,
    this.fullAddress,
    this.placeFormatted,
    this.featureType,
    this.maki,
    this.poiCategory,
    this.countryName,
    this.regionName,
  });

  @override
  List<Object?> get props => [
    mapboxId,
    name,
    latitude,
    longitude,
    address,
    fullAddress,
    placeFormatted,
    featureType,
    maki,
    poiCategory,
    countryName,
    regionName,
  ];
}
