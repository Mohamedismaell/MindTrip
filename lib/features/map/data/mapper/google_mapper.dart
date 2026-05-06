import 'package:mindtrip/features/map/data/models/google_place_model.dart';
import 'package:mindtrip/features/map/data/models/google_place_photo.dart';
import 'package:mindtrip/features/map/data/models/google_place_opening_hours.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';
import 'package:mindtrip/features/map/domain/entities/google_place_opening_hours.dart';
import 'package:mindtrip/features/map/domain/entities/google_place_photo.dart';

extension GooglePlacesMapper on GooglePlaceModel {
  GooglePlaceEntity toEntity() {
    return GooglePlaceEntity(
      placeId: placeId,
      displayName: displayName,
      formattedAddress: formattedAddress,
      latitude: latitude,
      longitude: longitude,
      rating: rating,
      userRatingCount: userRatingCount,
      primaryType: primaryType,
      types: types,
      photos: photos?.map((p) => p.toEntity()).toList(),
      phoneNumber: phoneNumber,
      websiteUri: websiteUri,
      openingHours: openingHours?.toEntity(),
      editorialSummary: editorialSummary?.overview,
      priceLevel: priceLevel,
    );
  }
}

extension GooglePlacePhotoMapper on GooglePlacePhotoModel {
  GooglePlacePhotoEntity toEntity() {
    return GooglePlacePhotoEntity(
      photoReference: photoReference,
      height: heightPx,
      width: widthPx,
      attribution: attribution,
    );
  }
}

extension GooglePlaceOpeningHoursMapper on GooglePlaceOpeningHoursModel {
  GooglePlaceOpeningHoursEntity toEntity() {
    return GooglePlaceOpeningHoursEntity(
      openNow: openNow,
      weekdayDescriptions: weekdayDescriptions,
    );
  }
}
