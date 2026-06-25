import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/plan_place_entity.dart';

class DayPlanEntity extends Equatable {
  const DayPlanEntity({
    required this.morning,
    required this.afternoon,
    required this.evening,
  });

  final List<PlanPlaceEntity> morning;
  final List<PlanPlaceEntity> afternoon;
  final List<PlanPlaceEntity> evening;

  List<PlanPlaceEntity> get allPlaces => [...morning, ...afternoon, ...evening];

  @override
  List<Object?> get props => [morning, afternoon, evening];
}
