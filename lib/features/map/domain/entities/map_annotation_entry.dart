import 'dart:ui';

import 'package:equatable/equatable.dart';
import '../../../../core/shared/domain/entities/place_entity.dart';

import 'package:mindtrip/features/map/domain/entities/google_place.dart';

class MapAnnotationEntry extends Equatable {
  final PlaceEntity place;
  final int sequenceNumber;
  final String? mapboxAnnotationId;

  final Color? periodColor;

  final String? periodLabel;

  final int? dayNumber;

  final bool isSearchResult;

  final GooglePlaceEntity? googlePlace;

  const MapAnnotationEntry({
    required this.place,
    required this.sequenceNumber,
    this.mapboxAnnotationId,
    this.periodColor,
    this.periodLabel,
    this.dayNumber,
    this.isSearchResult = false,
    this.googlePlace,
  });

  MapAnnotationEntry copyWith({
    PlaceEntity? place,
    int? sequenceNumber,
    String? mapboxAnnotationId,
    Color? periodColor,
    String? periodLabel,
    int? dayNumber,
    bool? isSearchResult,
    GooglePlaceEntity? googlePlace,
  }) {
    return MapAnnotationEntry(
      place: place ?? this.place,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      mapboxAnnotationId: mapboxAnnotationId ?? this.mapboxAnnotationId,
      periodColor: periodColor ?? this.periodColor,
      periodLabel: periodLabel ?? this.periodLabel,
      dayNumber: dayNumber ?? this.dayNumber,
      isSearchResult: isSearchResult ?? this.isSearchResult,
      googlePlace: googlePlace ?? this.googlePlace,
    );
  }

  @override
  List<Object?> get props => [
    place,
    sequenceNumber,
    mapboxAnnotationId,
    periodColor,
    periodLabel,
    dayNumber,
    isSearchResult,
    googlePlace,
  ];
}
