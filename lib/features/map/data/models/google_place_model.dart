import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/map/data/models/google_place_opening_hours.dart';
import 'package:mindtrip/features/map/data/models/google_place_photo.dart';
import 'package:mindtrip/features/map/data/models/google_place_editorial_summary.dart';

class GooglePlaceModel extends Equatable {
  final String placeId;
  final String displayName;
  final String? formattedAddress;
  final double? latitude;
  final double? longitude;
  final double? rating;
  final int? userRatingCount;
  final String? primaryType;
  final List<String>? types;
  final List<GooglePlacePhotoModel>? photos;
  final String? phoneNumber;
  final String? websiteUri;
  final GooglePlaceOpeningHoursModel? openingHours;
  final GooglePlaceEditorialSummaryModel? editorialSummary;
  final String? priceLevel;

  const GooglePlaceModel({
    required this.placeId,
    required this.displayName,
    this.formattedAddress,
    this.latitude,
    this.longitude,
    this.rating,
    this.userRatingCount,
    this.primaryType,
    this.types,
    this.photos,
    this.phoneNumber,
    this.websiteUri,
    this.openingHours,
    this.editorialSummary,
    this.priceLevel,
  });

  factory GooglePlaceModel.fromJson(Map<String, dynamic> json) {
    return GooglePlaceModel(
      placeId: json['place_id'] ?? '',
      displayName: json['name'] ?? '',
      formattedAddress: json['formatted_address'],
      latitude: json['geometry']?['location']?['lat']?.toDouble(),
      longitude: json['geometry']?['location']?['lng']?.toDouble(),
      rating: json['rating']?.toDouble(),
      userRatingCount: json['user_ratings_total'],
      primaryType: json['types'] != null ? json['types'][0] : null,
      types: (json['types'] as List?)?.cast<String>(),
      photos: (json['photos'] as List?)
          ?.map((e) => GooglePlacePhotoModel.fromJson(e))
          .toList(),
      phoneNumber: json['formatted_phone_number'],
      websiteUri: json['website'],
      openingHours: json['opening_hours'] != null
          ? GooglePlaceOpeningHoursModel.fromJson(json['opening_hours'])
          : null,
      editorialSummary: json['editorial_summary'] != null
          ? GooglePlaceEditorialSummaryModel.fromJson(json['editorial_summary'])
          : null,
      priceLevel: json['price_level']?.toString(),
    );
  }

  factory GooglePlaceModel.fromNearbyJson(Map<String, dynamic> json) {
    return GooglePlaceModel(
      placeId: json['id'] ?? '',
      displayName: json['displayName']?['text'] ?? '',
      formattedAddress: json['formattedAddress'],
      latitude: json['location']?['latitude']?.toDouble(),
      longitude: json['location']?['longitude']?.toDouble(),
      rating: json['rating']?.toDouble(),
      userRatingCount: json['userRatingCount'],
      primaryType: json['primaryType'],
      photos: (json['photos'] as List?)
          ?.map((e) => GooglePlacePhotoModel.fromNearbyJson(e))
          .toList(),
    );
  }

  bool get hasLocation => latitude != null && longitude != null;

  String? get firstPhotoRef => photos != null && photos!.isNotEmpty
      ? photos!.first.photoReference
      : null;

  String get category {
    if (types == null || types!.isEmpty) return 'other';

    if (types!.contains('restaurant')) return 'restaurant';
    if (types!.contains('lodging')) return 'hotel';
    if (types!.contains('park')) return 'park';
    if (types!.contains('museum')) return 'museum';

    return 'other';
  }

  @override
  List<Object?> get props => [
    placeId,
    displayName,
    formattedAddress,
    latitude,
    longitude,
    rating,
    userRatingCount,
    primaryType,
    types,
    photos,
    phoneNumber,
    websiteUri,
    openingHours,
    editorialSummary,
    priceLevel,
  ];
}
