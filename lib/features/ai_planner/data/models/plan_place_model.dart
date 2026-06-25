import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_place_model.freezed.dart';
part 'plan_place_model.g.dart';

@freezed
abstract class PlanPlaceModel with _$PlanPlaceModel {
  const factory PlanPlaceModel({
    @JsonKey(name: 'place_id') @Default('') String placeId,

    @Default('') String name,

    @Default('') String city,

    @JsonKey(name: 'city_en') @Default('') String cityEn,

    @Default('') String category,

    @JsonKey(fromJson: parseDouble) @Default(0) double rating,

    @JsonKey(name: 'reviews_count', fromJson: parseInt)
    @Default(0)
    int reviewsCount,

    @Default('') String address,

    @Default('') String description,

    @JsonKey(name: 'photo_url') @Default('') String photoUrl,

    @JsonKey(name: 'image_urls') @Default(<String>[]) List<String> imageUrls,

    @JsonKey(name: 'maps_url') @Default('') String mapsUrl,

    @JsonKey(fromJson: parseDouble) @Default(0) double lat,

    @JsonKey(fromJson: parseDouble) @Default(0) double lng,

    @JsonKey(fromJson: parseInt) @Default(0) int day,

    @Default('') String type,

    @JsonKey(fromJson: parseDouble) @Default(0) double price,

    @JsonKey(fromJson: parseDouble) @Default(0) double cost,

    @Default(<String>[]) List<String> interests,

    @JsonKey(name: 'is_hidden_gem') @Default(false) bool isHiddenGem,

    @JsonKey(name: 'opening_hours') @Default('') String openingHours,

    @JsonKey(name: 'is_opened', fromJson: parseBool)
    @Default(false)
    bool isOpened,
  }) = _PlanPlaceModel;

  factory PlanPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlanPlaceModelFromJson(json);
}

double parseDouble(dynamic value) {
  if (value == null || value == '') return 0;

  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value.toString()) ?? 0;
}

int parseInt(dynamic value) {
  if (value == null || value == '') return 0;

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value.toString()) ?? 0;
}

bool parseBool(dynamic value) {
  return value == true || value == 'true' || value == 'True';
}
