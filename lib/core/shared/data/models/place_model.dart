import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@freezed
@HiveType(typeId: 6)
abstract class PlaceModel with _$PlaceModel {
  const PlaceModel._();

  const factory PlaceModel({
    @HiveField(0) @JsonKey(name: 'place_id') required String placeId,
    @HiveField(1) required String name,
    @HiveField(2) String? city,
    @HiveField(3) @JsonKey(name: 'city_en') String? cityEn,
    @HiveField(4) @JsonKey(fromJson: _toListOfStrings) List<String>? interests,
    @HiveField(5) String? category,

    /// Price per person
    @HiveField(6) @JsonKey(fromJson: _toDouble) double? price,

    /// Total estimated cost
    @HiveField(7) @JsonKey(fromJson: _toDouble) double? cost,

    @HiveField(8) @JsonKey(fromJson: _toDouble) double? rating,
    @HiveField(9) @JsonKey(name: 'reviews_count') int? reviewsCount,
    @HiveField(10) String? address,
    @HiveField(11) String? description,
    @HiveField(12) @JsonKey(name: 'photo_url') String? photoUrl,
    @HiveField(13)
    @JsonKey(name: 'image_urls', fromJson: _toListOfStrings)
    List<String>? imageUrls,
    @HiveField(14) @JsonKey(name: 'opening_hours') String? openingHours,
    @HiveField(15)
    @JsonKey(fromJson: _toDoubleNonNullable)
    @Default(0.0)
    double lat,
    @HiveField(16)
    @JsonKey(fromJson: _toDoubleNonNullable)
    @Default(0.0)
    double lng,
    @HiveField(17)
    @JsonKey(name: 'is_hidden_gem')
    @Default(false)
    bool isHiddenGem,
    @HiveField(18) @JsonKey(name: 'maps_url') String? mapsUrl,

    // New fields from sample
    @HiveField(19) String? day,
    @HiveField(20) @JsonKey(name: 'is_opened') String? isOpened,
    @HiveField(21) String? type,
  }) = _PlaceModel;

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  // compatibility getters
  String get id => placeId;
}

double? _toDouble(Object? value) => (value as num?)?.toDouble();

double _toDoubleNonNullable(Object? value) =>
    (value as num?)?.toDouble() ?? 0.0;

List<String>? _toListOfStrings(Object? value) {
  if (value == null) return null;
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }
  if (value is Map && value['items'] is List) {
    return (value['items'] as List).map((e) => e.toString()).toList();
  }
  return null;
}
