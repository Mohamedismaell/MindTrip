import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/utils/json_parser.dart';

class PlanPlaceModel extends Equatable {
  const PlanPlaceModel({
    this.placeId = '',
    this.name = '',
    this.city = '',
    this.cityEn = '',
    this.interests = const [],
    this.category = '',
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.address = '',
    this.description = '',
    this.photoUrl = '',
    this.imageUrls = const [],
    this.mapsUrl = '',
    this.openingHours = '',
    this.isOpened = false,
    this.lat = 0.0,
    this.lng = 0.0,
    this.day = 0,
    this.type = '',
    this.price = 0,
    this.cost = 0,
    this.isHiddenGem = false,
  });

  final String placeId;
  final String name;
  final String city;
  final String cityEn;
  final List<String> interests;
  final String category;
  final double rating;
  final int reviewsCount;
  final String address;
  final String description;
  final String photoUrl;
  final List<String> imageUrls;
  final String mapsUrl;
  final String openingHours;
  final bool isOpened;
  final double lat;
  final double lng;
  final int day;
  final String type;
  final int price;
  final int cost;
  final bool isHiddenGem;

  factory PlanPlaceModel.fromJson(Map<String, dynamic> json) {
    return PlanPlaceModel(
      placeId: parseString(json['place_id']),
      name: parseString(json['name']),
      city: parseString(json['city']),
      cityEn: parseString(json['city_en']),
      interests: parseStringList(json['interests']),
      category: parseString(json['category']),
      rating: parseDouble(json['rating']),
      reviewsCount: parseInt(json['reviews_count']),
      address: parseString(json['address']),
      description: parseString(json['description']),
      photoUrl: parseString(json['photo_url']),
      imageUrls: parseStringList(json['image_urls']),
      mapsUrl: parseString(json['maps_url']),
      openingHours: parseString(json['opening_hours']),
      isOpened: parseBool(json['is_opened']),
      lat: parseDouble(json['lat']),
      lng: parseDouble(json['lng']),
      day: parseDay(json['day']),
      type: parseString(json['type']),
      price: parseInt(json['price']),
      cost: parseInt(json['cost']),
      isHiddenGem: parseBool(json['is_hidden_gem']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'name': name,
      'city': city,
      'city_en': cityEn,
      'interests': interests,
      'category': category,
      'rating': rating,
      'reviews_count': reviewsCount,
      'address': address,
      'description': description,
      'photo_url': photoUrl,
      'image_urls': imageUrls,
      'maps_url': mapsUrl,
      'opening_hours': openingHours,
      'is_opened': isOpened,
      'lat': lat,
      'lng': lng,
      'day': day,
      'type': type,
      'price': price,
      'cost': cost,
      'is_hidden_gem': isHiddenGem,
    };
  }

  PlanPlaceModel copyWith({
    String? placeId,
    String? name,
    String? city,
    String? cityEn,
    List<String>? interests,
    String? category,
    double? rating,
    int? reviewsCount,
    String? address,
    String? description,
    String? photoUrl,
    List<String>? imageUrls,
    String? mapsUrl,
    String? openingHours,
    bool? isOpened,
    double? lat,
    double? lng,
    int? day,
    String? type,
    int? price,
    int? cost,
    bool? isHiddenGem,
  }) {
    return PlanPlaceModel(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      city: city ?? this.city,
      cityEn: cityEn ?? this.cityEn,
      interests: interests ?? this.interests,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      address: address ?? this.address,
      description: description ?? this.description,
      photoUrl: photoUrl ?? this.photoUrl,
      imageUrls: imageUrls ?? this.imageUrls,
      mapsUrl: mapsUrl ?? this.mapsUrl,
      openingHours: openingHours ?? this.openingHours,
      isOpened: isOpened ?? this.isOpened,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      day: day ?? this.day,
      type: type ?? this.type,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      isHiddenGem: isHiddenGem ?? this.isHiddenGem,
    );
  }

  @override
  List<Object?> get props => [
    placeId,
    name,
    city,
    cityEn,
    interests,
    category,
    rating,
    reviewsCount,
    address,
    description,
    photoUrl,
    imageUrls,
    mapsUrl,
    openingHours,
    isOpened,
    lat,
    lng,
    day,
    type,
    price,
    cost,
    isHiddenGem,
  ];
}
