import 'package:equatable/equatable.dart';

class PlanPlaceEntity extends Equatable {
  const PlanPlaceEntity({
    required this.placeId,
    required this.name,
    required this.city,
    required this.cityEn,
    required this.category,
    required this.rating,
    required this.reviewsCount,
    required this.address,
    required this.description,
    required this.photoUrl,
    required this.imageUrls,
    required this.mapsUrl,
    required this.lat,
    required this.lng,
    required this.day,
    required this.type,
    required this.price,
    required this.cost,
    required this.interests,
    required this.isHiddenGem,
    required this.openingHours,
    required this.isOpened,
  });

  final String placeId;
  final String name;
  final String city;
  final String cityEn;
  final String category;
  final double rating;
  final int reviewsCount;
  final String address;
  final String description;
  final String photoUrl;
  final List<String> imageUrls;
  final String mapsUrl;
  final double lat;
  final double lng;
  final int day;
  final String type;
  final double price;
  final double cost;
  final List<String> interests;
  final bool isHiddenGem;
  final String openingHours;
  final bool isOpened;

  @override
  List<Object?> get props => [
    placeId,
    name,
    city,
    cityEn,
    category,
    rating,
    reviewsCount,
    address,
    description,
    photoUrl,
    imageUrls,
    mapsUrl,
    lat,
    lng,
    day,
    type,
    price,
    cost,
    interests,
    isHiddenGem,
    openingHours,
    isOpened,
  ];
}
