import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';

class PlanModel {
  const PlanModel({this.accommodation = const [], this.days = const {}});

  final List<PlanPlaceModel> accommodation;
  final Map<int, DayPlanModel> days;

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    final accommodation =
        (json['accommodation'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .map(PlanPlaceModel.fromJson)
            .toList() ??
        const <PlanPlaceModel>[];

    final days = <int, DayPlanModel>{};

    for (final entry in json.entries) {
      if (!entry.key.startsWith('day')) continue;

      final day = int.tryParse(entry.key.substring(3));
      if (day == null) continue;

      if (entry.value is Map<String, dynamic>) {
        days[day] = DayPlanModel.fromJson(entry.value);
      }
    }

    return PlanModel(accommodation: accommodation, days: days);
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'accommodation': accommodation.map((e) => e.toJson()).toList(),
    };

    final sortedDays = days.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    for (final entry in sortedDays) {
      json['day${entry.key}'] = entry.value.toJson();
    }

    return json;
  }

  PlanModel copyWith({
    List<PlanPlaceModel>? accommodation,
    Map<int, DayPlanModel>? days,
  }) {
    return PlanModel(
      accommodation: accommodation ?? this.accommodation,
      days: days ?? this.days,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanModel &&
          other.accommodation == accommodation &&
          other.days == days;

  @override
  int get hashCode => Object.hash(accommodation, days);
}
