import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/enums/place_badge.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'location_model.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@freezed
abstract class PlaceModel with _$PlaceModel {
  @HiveType(typeId: 1, adapterName: 'PlaceModelAdapter')
  const factory PlaceModel({
    @HiveField(0) @Default('') String id,
    @HiveField(1) @Default('') String name,
    @HiveField(2) String? description,
    @HiveField(3) required LocationModel location,
    @HiveField(4) List<String>? coverImage,
    @HiveField(5) List<String>? imageUrls,
    @HiveField(6) @Default(PlaceCategory.other) PlaceCategory category,
    @HiveField(7) double? rating,
    @HiveField(8) int? reviewCount,
    @HiveField(9) double? price,
    @HiveField(10) @Default(false) bool isFavorite,
    @HiveField(11) @Default(PlaceBadge.none) PlaceBadge badge,
  }) = _PlaceModel;

  const PlaceModel._();

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
}
