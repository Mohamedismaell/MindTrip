import 'dart:ui';

import 'package:equatable/equatable.dart';
import '../../../../core/shared/data/models/place_model.dart';

class MapAnnotationEntry extends Equatable {
  final PlaceModel place;
  final int sequenceNumber;
  final String? mapboxAnnotationId;

  /// Colour associated with the day period (morning/afternoon/evening).
  final Color? periodColor;

  /// Human-readable period label, e.g. "Morning", "Afternoon", "Evening".
  final String? periodLabel;

  /// Day number this entry belongs to (1-indexed). Null when no trip context.
  final int? dayNumber;

  const MapAnnotationEntry({
    required this.place,
    required this.sequenceNumber,
    this.mapboxAnnotationId,
    this.periodColor,
    this.periodLabel,
    this.dayNumber,
  });

  MapAnnotationEntry copyWith({
    PlaceModel? place,
    int? sequenceNumber,
    String? mapboxAnnotationId,
    Color? periodColor,
    String? periodLabel,
    int? dayNumber,
  }) {
    return MapAnnotationEntry(
      place: place ?? this.place,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      mapboxAnnotationId: mapboxAnnotationId ?? this.mapboxAnnotationId,
      periodColor: periodColor ?? this.periodColor,
      periodLabel: periodLabel ?? this.periodLabel,
      dayNumber: dayNumber ?? this.dayNumber,
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
      ];
}
