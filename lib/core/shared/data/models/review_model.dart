import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
abstract class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    @Default('') String id,
    @Default('') String userId,
    @Default('') String placeId,
    @Default('') String location,
    @Default(0.0) double rating,
    @Default('') String title,
    @Default('') String body,
    DateTime? createdAt,
  }) = _ReviewModel;

  const ReviewModel._();

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}
