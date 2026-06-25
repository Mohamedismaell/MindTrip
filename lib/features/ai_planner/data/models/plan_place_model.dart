import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/utils/json_parser.dart';

part 'plan_place_model.freezed.dart';
part 'plan_place_model.g.dart';

@freezed
abstract class PlanPlaceModel with _$PlanPlaceModel {
  const factory PlanPlaceModel({
    @JsonKey(name: 'place_id') required String placeId,

    required String name,

    required String city,

    @JsonKey(name: 'city_en') required String cityEn,

    required String category,

    @JsonKey(fromJson: parseDouble) required double rating,

    @JsonKey(name: 'reviews_count', fromJson: parseInt)
    required int reviewsCount,

    required String address,

    required String description,

    @JsonKey(name: 'photo_url') required String photoUrl,

    @JsonKey(name: 'image_urls', fromJson: parseStringList)
    required List<String> imageUrls,

    @JsonKey(name: 'maps_url') required String mapsUrl,

    @JsonKey(fromJson: parseDouble) required double lat,

    @JsonKey(fromJson: parseDouble) required double lng,

    @JsonKey(fromJson: parseDay) required int day,

    required String type,

    @JsonKey(fromJson: parseDouble) required double price,

    @JsonKey(fromJson: parseDouble) required double cost,

    @JsonKey(fromJson: parseStringList) required List<String> interests,

    @JsonKey(name: 'is_hidden_gem') required bool isHiddenGem,

    @JsonKey(name: 'opening_hours') required String openingHours,

    @JsonKey(name: 'is_opened', fromJson: parseBool) required bool isOpened,
  }) = _PlanPlaceModel;

  factory PlanPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlanPlaceModelFromJson(json);
}
