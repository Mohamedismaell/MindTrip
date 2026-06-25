import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/utils/json_parser.dart';

part 'plan_place_model.freezed.dart';
part 'plan_place_model.g.dart';

@freezed
abstract class PlanPlaceModel with _$PlanPlaceModel {
  const factory PlanPlaceModel({
    @JsonKey(name: 'place_id', fromJson: parseString)
    @Default('')
    String placeId,

    @JsonKey(fromJson: parseString) @Default('') String name,

    @JsonKey(fromJson: parseString) @Default('') String city,

    @JsonKey(name: 'city_en', fromJson: parseString) @Default('') String cityEn,

    @JsonKey(fromJson: parseStringList) @Default([]) List<String> interests,

    @JsonKey(fromJson: parseString) @Default('') String category,

    @JsonKey(fromJson: parseDouble) @Default(0.0) double rating,

    @JsonKey(name: 'reviews_count', fromJson: parseInt)
    @Default(0)
    int reviewsCount,

    @JsonKey(fromJson: parseString) @Default('') String address,

    @JsonKey(fromJson: parseString) @Default('') String description,

    @JsonKey(name: 'photo_url', fromJson: parseString)
    @Default('')
    String photoUrl,

    @JsonKey(name: 'image_urls', fromJson: parseStringList)
    @Default([])
    List<String> imageUrls,

    @JsonKey(name: 'maps_url', fromJson: parseString)
    @Default('')
    String mapsUrl,

    @JsonKey(name: 'opening_hours', fromJson: parseString)
    @Default('')
    String openingHours,

    @JsonKey(name: 'is_opened', fromJson: parseBool) @Default(false) bool isOpened,

    @JsonKey(fromJson: parseDouble) @Default(0.0) double lat,

    @JsonKey(fromJson: parseDouble) @Default(0.0) double lng,

    @JsonKey(fromJson: parseDay) @Default(0) int day,

    @JsonKey(fromJson: parseString) @Default('') String type,

    @JsonKey(fromJson: parseInt) @Default(0) int price,

    @JsonKey(fromJson: parseInt) @Default(0) int cost,

    @JsonKey(name: 'is_hidden_gem', fromJson: parseBool)
    @Default(false)
    bool isHiddenGem,
  }) = _PlanPlaceModel;

  factory PlanPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlanPlaceModelFromJson(json);
}
