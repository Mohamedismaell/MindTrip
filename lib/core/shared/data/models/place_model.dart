import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'location_model.dart';

part 'place_model.g.dart';

//Todo: add cover image or depend on the liast of the images and take the first but it will be too much load i think so nvm
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
  final List<String>? coverImage;
  @HiveField(5)
  final List<String>? imageUrls;
  @HiveField(6)
  final PlaceCategory category;
  @HiveField(7)
  final double? rating;
  @HiveField(8)
  final int? reviewCount;
  @HiveField(9)
  final double? price;
  @HiveField(10)
  final bool isFavorite;
  @HiveField(11)
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
    this.coverImage,
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

  PlaceModel copyWith({
    String? id,
    String? name,
    String? description,
    LocationModel? location,
    List<String>? imageUrls,
    PlaceCategory? category,
    double? rating,
    int? reviewCount,
    double? price,
    bool? isFavorite,
    PlaceBadge? badge,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      imageUrls: imageUrls ?? this.imageUrls,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
      badge: badge ?? this.badge,
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
    isFavorite,
  ];
}
