import 'package:equatable/equatable.dart';
import '../../../../core/shared/data/models/place_model.dart';

class MapAnnotationEntry extends Equatable {
  final PlaceModel place;
  final int sequenceNumber;
  final String? mapboxAnnotationId;

  const MapAnnotationEntry({
    required this.place,
    required this.sequenceNumber,
    this.mapboxAnnotationId,
  });

  MapAnnotationEntry copyWith({
    PlaceModel? place,
    int? sequenceNumber,
    String? mapboxAnnotationId,
  }) {
    return MapAnnotationEntry(
      place: place ?? this.place,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      mapboxAnnotationId: mapboxAnnotationId ?? this.mapboxAnnotationId,
    );
  }

  @override
  List<Object?> get props => [place, sequenceNumber, mapboxAnnotationId];
}
