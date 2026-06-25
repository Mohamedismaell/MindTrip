import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/utils/generated_plan_model_helpers.dart';
import 'package:mindtrip/core/utils/json_parser.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';

part 'generated_plan_model.freezed.dart';

@freezed
abstract class GeneratedPlanModel with _$GeneratedPlanModel {
  const factory GeneratedPlanModel({
    required String tripId,
    required String status,
    required int people,
    required int totalCalculatedCost,
    required int daysCount,
    required List<PlanPlaceModel> accommodation,
    required Map<int, DayPlanModel> days,
  }) = _GeneratedPlanModel;

  factory GeneratedPlanModel.fromJson(Map<String, dynamic> json) {
    final plan = json['plan'] as Map<String, dynamic>? ?? {};

    return GeneratedPlanModel(
      tripId: json['trip_id'] ?? '',
      status: json['status'] ?? '',
      people: parseInt(json['people']),
      totalCalculatedCost: parseInt(json['total_calculated_cost']),
      daysCount: parseInt(json['days_count']),
      accommodation: parsePlaces(plan['accommodation']),
      days: parseDays(plan),
    );
  }
}
