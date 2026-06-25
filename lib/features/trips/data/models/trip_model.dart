import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_model.freezed.dart';
part 'trip_model.g.dart';

@freezed
abstract class TripModel with _$TripModel {
  const factory TripModel({
    required String tripId,
    required String title,
    required String destinationGovernorate,
    required String city,
    DateTime? startDate,
    DateTime? endDate,
    int? durationDays,
    required int people,
    required int totalBudgetEgp,
    required int totalCost,
    required String status,
    String? shareToken,
    @Default(false) bool isPublic,
    String? sessionId,
    String? collectedJson,
    String? coverImageUrl,
    @Default(0) int placesCount,
    double? progressPercent,
    required DateTime createdAt,
    required DateTime updatedAt,
    dynamic plan,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);
}
