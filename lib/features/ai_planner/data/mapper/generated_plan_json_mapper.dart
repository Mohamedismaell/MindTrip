import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

extension GeneratedPlanJsonMapper on GeneratedPlanModel {
  Map<String, dynamic> toJson() {
    final daysMap = <String, dynamic>{};

    days.forEach((key, value) {
      daysMap['day$key'] = value.toJson();
    });

    return {
      'trip_id': tripId,
      'status': status,
      'people': people,
      'total_calculated_cost': totalCalculatedCost,
      'days_count': daysCount,
      'plan': {
        'accommodation': accommodation.map((e) => e.toJson()).toList(),
        ...daysMap,
      },
    };
  }
}
