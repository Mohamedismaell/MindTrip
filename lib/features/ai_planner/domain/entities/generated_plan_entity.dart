import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/day_plan_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/plan_place_entity.dart';

class GeneratedPlanEntity extends Equatable {
  const GeneratedPlanEntity({
    required this.tripId,
    required this.status,
    required this.people,
    required this.totalCalculatedCost,
    required this.daysCount,
    required this.accommodation,
    required this.days,
  });

  final String tripId;
  final String status;
  final int people;
  final int totalCalculatedCost;
  final int daysCount;
  final List<PlanPlaceEntity> accommodation;
  final Map<int, DayPlanEntity> days;
  List<PlanPlaceEntity> get allPlaces => [
    // ...accommodation,
    ...days.values.expand((day) => day.allPlaces),
  ];

  int get placesCount {
    var count = accommodation.length;

    for (final day in days.values) {
      count += day.placesCount;
    }

    return count;
  }

  @override
  List<Object?> get props => [
    tripId,
    status,
    people,
    totalCalculatedCost,
    daysCount,
    accommodation,
    days,
  ];
}
