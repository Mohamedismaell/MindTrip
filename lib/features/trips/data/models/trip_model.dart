import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

part 'trip_model.freezed.dart';
part 'trip_model.g.dart';

@freezed
abstract class TripModel with _$TripModel {
  const factory TripModel({
    required String tripId,

    required String title,

    required String destinationGovernorate,

    required String city,

    required DateTime startDate,

    required DateTime endDate,

    required int durationDays,

    required int people,

    required int totalBudgetEgp,

    required int totalCost,

    required String status,

    required String shareToken,

    required bool isPublic,

    required String sessionId,

    @JsonKey(
      name: 'collectedJson',
      fromJson: TripModel._collectedFromJson,
      toJson: TripModel._collectedToJson,
    )
    required CollectedDataModel collected,

    required String coverImageUrl,

    required int placesCount,

    required int progressPercent,

    required DateTime createdAt,

    required DateTime updatedAt,

    required GeneratedPlanModel plan,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  static CollectedDataModel _collectedFromJson(dynamic json) {
    if (json == null) {
      return CollectedDataModel.empty();
    }

    if (json is String) {
      if (json.isEmpty) {
        return CollectedDataModel.empty();
      }

      return CollectedDataModel.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
    }

    if (json is Map<String, dynamic>) {
      return CollectedDataModel.fromJson(json);
    }

    throw ArgumentError('Unsupported collectedJson type: ${json.runtimeType}');
  }

  static String _collectedToJson(CollectedDataModel model) {
    return jsonEncode(model.toJson());
  }
}
