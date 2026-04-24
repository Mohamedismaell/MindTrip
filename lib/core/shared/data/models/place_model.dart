import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'location_model.dart';

class PlaceModel extends Equatable {
  final String id;
  final String name;
  final String? description;
  final LocationModel location;
  final List<String>? imageUrls;
  final String thumbnailUrl;
  final String? categoryId;
  final double? rating;
  final int? reviewCount;
  final double? price;
  final bool isFavorite;
  final PlaceBadge badge;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.location,
    required this.thumbnailUrl,
    this.imageUrls,
    this.description,
    this.categoryId,
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
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      categoryId: json['categoryId'],
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
      'thumbnailUrl': thumbnailUrl,
      'categoryId': categoryId,
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
    thumbnailUrl,
    categoryId,
    rating,
    reviewCount,
    price,
    isFavorite,
  ];
}
