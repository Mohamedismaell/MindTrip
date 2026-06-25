import 'dart:convert';

import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';

List<PlanPlaceModel> parsePlaces(dynamic value) {
  if (value is! List) {
    return [];
  }

  return value
      .whereType<Map<String, dynamic>>()
      .map(PlanPlaceModel.fromJson)
      .toList();
}

Map<int, DayPlanModel> parseDays(Map<String, dynamic> plan) {
  final result = <int, DayPlanModel>{};

  for (final entry in plan.entries) {
    if (!entry.key.startsWith('day')) {
      continue;
    }

    final dayNumber = int.tryParse(entry.key.replaceFirst('day', ''));

    if (dayNumber == null) {
      continue;
    }
    print(jsonEncode(entry.value));
    final json = entry.value as Map<String, dynamic>;

    result[dayNumber] = DayPlanModel.fromJson(json);
  }

  return result;
}
