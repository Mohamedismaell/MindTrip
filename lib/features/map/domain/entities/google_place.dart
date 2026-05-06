import 'package:equatable/equatable.dart';
import 'google_place_photo.dart';
import 'google_place_opening_hours.dart';

class GooglePlaceEntity extends Equatable {
  final String placeId;
  final String displayName;
  final String? formattedAddress;
  final double? latitude;
  final double? longitude;
  final double? rating;
  final int? userRatingCount;
  final String? primaryType;
  final List<String>? types;
  final List<GooglePlacePhotoEntity>? photos;
  final String? phoneNumber;
  final String? websiteUri;
  final GooglePlaceOpeningHoursEntity? openingHours;
  final String? editorialSummary;
  final String? priceLevel;

  const GooglePlaceEntity({
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
