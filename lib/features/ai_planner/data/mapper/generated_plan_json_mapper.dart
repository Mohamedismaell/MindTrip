import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

extension GeneratedPlanJsonMapper on GeneratedPlanModel {
  /// Serialises the model back to the same shape the backend sends.
  Map<String, dynamic> toJson() {
    final planData = plan;

    // Build the day entries dynamically from the Map<int, DayPlanModel>.
    final daysMap = <String, dynamic>{};
    if (planData != null) {
      planData.days.forEach((dayNumber, dayPlan) {
        daysMap['day$dayNumber'] = dayPlan.toJson();
      });
    }

    return {
      'trip_id': tripId,
      'status': status,
      'people': people,
      'total_calculated_cost': totalCalculatedCost,
      'days_count': daysCount,
      'plan': {
        'accommodation':
            planData?.accommodation.map((e) => e.toJson()).toList() ?? [],
        ...daysMap,
      },
    };
  }
}
