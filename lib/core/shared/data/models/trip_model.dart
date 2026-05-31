import 'package:freezed_annotation/freezed_annotation.dart';
import 'place_model.dart';

part 'trip_model.freezed.dart';
part 'trip_model.g.dart';

@freezed
abstract class TripModel with _$TripModel {
  const factory TripModel({
    @Default('') String id,
    @Default('') String title,
    @Default('') String subtitle,
    @Default('') String imageUrl,
    @Default([]) List<PlaceModel> places,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isFavorite,
    @Default(false) bool isAiGenerated,
  }) = _TripModel;

  const TripModel._();

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);
}
