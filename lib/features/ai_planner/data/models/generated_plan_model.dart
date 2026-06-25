import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';

import 'plan_place_model.dart';

part 'generated_plan_model.freezed.dart';

@freezed
abstract class GeneratedPlanModel with _$GeneratedPlanModel {
  const factory GeneratedPlanModel({
    required String tripId,
    required String status,
    required int people,
    required double totalCalculatedCost,
    required int daysCount,
    required List<PlanPlaceModel> accommodation,
    required Map<int, DayPlanModel> days,
  }) = _GeneratedPlanModel;

  factory GeneratedPlanModel.fromJson(Map<String, dynamic> json) {
    final plan = json['plan'] as Map<String, dynamic>? ?? {};

    final days = <int, DayPlanModel>{};

    for (final entry in plan.entries) {
      if (!entry.key.startsWith('day')) {
        continue;
      }

      final dayNumber = int.tryParse(entry.key.replaceFirst('day', ''));

      if (dayNumber == null) {
        continue;
      }

      days[dayNumber] = DayPlanModel.fromJson(
        entry.value as Map<String, dynamic>,
      );
    }

    return GeneratedPlanModel(
      tripId: json['trip_id'] ?? '',
      status: json['status'] ?? '',
      people: json['people'] ?? 0,
      totalCalculatedCost: parseDouble(json['total_calculated_cost']),
      daysCount: json['days_count'] ?? 0,
      accommodation: _parseAccommodation(plan['accommodation']),
      days: days,
    );
  }
}

List<PlanPlaceModel> _parseAccommodation(dynamic value) {
  if (value is! List) {
    return [];
  }

  return value
      .whereType<Map<String, dynamic>>()
      .map(PlanPlaceModel.fromJson)
      .toList();
}
