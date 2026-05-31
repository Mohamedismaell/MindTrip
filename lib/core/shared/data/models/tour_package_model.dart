import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/data/models/location_model.dart';

part 'tour_package_model.freezed.dart';
part 'tour_package_model.g.dart';

@freezed
abstract class TourPackageModel with _$TourPackageModel {
  const factory TourPackageModel({
    @Default('') String id,
    @Default('') String title,
    required LocationModel location,
    @Default('') String imageUrl,
    @Default(0.0) double price,
    @Default(0.0) double rating,
    @Default(0) int durationDays,
  }) = _TourPackageModel;

  const TourPackageModel._();

  factory TourPackageModel.fromJson(Map<String, dynamic> json) =>
      _$TourPackageModelFromJson(json);
}
