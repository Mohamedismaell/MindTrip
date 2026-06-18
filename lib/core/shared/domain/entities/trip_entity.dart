import 'package:equatable/equatable.dart';
import '../../../../features/places/domain/entity/place_entity.dart';

class TripEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final List<PlaceEntity> places;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isFavorite;
  final bool isAiGenerated;

  const TripEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.places = const [],
    this.startDate,
    this.endDate,
    this.isFavorite = false,
    this.isAiGenerated = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    imageUrl,
    places,
    startDate,
    endDate,
    isFavorite,
    isAiGenerated,
  ];
}
