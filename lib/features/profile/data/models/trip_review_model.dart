import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_review_model.freezed.dart';
part 'trip_review_model.g.dart';

@freezed
abstract class TripReviewModel with _$TripReviewModel {
  const factory TripReviewModel({
    required String tripReviewId,
    required String tripId,
    required String destination,
    required double rating,
    required String comment,
    required DateTime createdAt,
  }) = _TripReviewModel;

  factory TripReviewModel.fromJson(Map<String, dynamic> json) =>
      _$TripReviewModelFromJson(json);
}
