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

  int get placesCount => allPlaces.length;

  double get totalCost =>
      allPlaces.fold<double>(0, (sum, place) => sum + place.cost);

  double get averageRating => placesCount == 0
      ? 0
      : allPlaces.fold<double>(0, (sum, place) => sum + place.rating) /
            placesCount;

  @override
  List<Object?> get props => [morning, afternoon, evening];
}
