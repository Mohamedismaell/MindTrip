import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

part 'favorite_place_model.freezed.dart';
part 'favorite_place_model.g.dart';

@freezed
abstract class FavoritePlaceModel with _$FavoritePlaceModel {
  const factory FavoritePlaceModel({
    required String favoritePlaceId,
    required String placeId,
    required PlaceModel place,
  }) = _FavoritePlaceModel;

  factory FavoritePlaceModel.fromJson(Map<String, dynamic> json) =>
      _$FavoritePlaceModelFromJson(json);
}
