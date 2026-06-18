import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';

class TourPackageEntity extends Equatable {
  final String id;
  final String title;
  final LocationEntity location;
  final String imageUrl;
  final double price;
  final double rating;
  final int durationDays;

  const TourPackageEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.durationDays,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    imageUrl,
    price,
    rating,
    durationDays,
  ];
}
