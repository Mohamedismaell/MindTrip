import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'location_model.dart';

part 'place_model.g.dart';

@HiveType(typeId: 1)
class PlaceModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final LocationModel location;
  @HiveField(4)
  final List<String>? imageUrls;
  @HiveField(5)
  final PlaceCategory category;
  @HiveField(6)
  final double? rating;
  @HiveField(7)
  final int? reviewCount;
  @HiveField(8)
  final double? price;
  @HiveField(9)
  final bool isFavorite;
  @HiveField(10)
  final PlaceBadge badge;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.location,
    this.imageUrls,
    this.description,
    this.category = PlaceCategory.other,
    this.rating,
    this.reviewCount,
    this.price,
    this.isFavorite = false,
    this.badge = PlaceBadge.none,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      location: LocationModel.fromJson(json['location'] ?? {}),
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      category: PlaceCategory.fromCategory(
        json['category'] ?? json['categoryId'],
      ),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      isFavorite: json['isFavorite'] ?? false,
      badge: PlaceBadgeExtension.fromString(json['badge'] ?? 'none'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location.toJson(),
      'imageUrls': imageUrls,
      'category': category.name,
      'rating': rating,
      'reviewCount': reviewCount,
      'price': price,
      'isFavorite': isFavorite,
      'badge': badge.name,
    };
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
    isFavorite,
  ];
}
