import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';

class PlaceEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final LocationEntity location;
  final List<String>? imageUrls;
  final PlaceCategory category;
  final double? rating;
  final int? reviewCount;
  final double? price;
  final String? openingHours;
  final String? isOpened;
  // final PlaceBadge badge;
  final bool? isHiddenGem;
  //* ========= Ui Helper =========
  final bool isFavorite;

  const PlaceEntity({
    required this.id,
    required this.name,
    required this.location,
    this.imageUrls,
    this.description,
    this.category = PlaceCategory.all,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.price,
    // this.badge = PlaceBadge.none,
    this.isFavorite = false,
    this.isHiddenGem,
    this.openingHours,
    this.isOpened,
  });

  PlaceEntity copyWith({
    String? id,
    String? name,
    String? description,
    LocationEntity? location,
    List<String>? imageUrls,
    PlaceCategory? category,
    double? rating,
    int? reviewCount,
    double? price,
    PlaceBadge? badge,
    bool? isFavorite,
    bool? isHiddenGem,
    String? openingHours,
    String? isOpened,
  }) {
    return PlaceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      imageUrls: imageUrls ?? this.imageUrls,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      price: price ?? this.price,
      // badge: badge ?? this.badge,
      isFavorite: isFavorite ?? this.isFavorite,
      isHiddenGem: isHiddenGem ?? this.isHiddenGem,
      openingHours: openingHours ?? this.openingHours,
      isOpened: isOpened ?? this.isOpened,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    location,
    imageUrls,
    category,
    rating,
    reviewCount,
    price,
    // badge,
    isFavorite,
    isHiddenGem,
    openingHours,
    isOpened,
  ];
}
