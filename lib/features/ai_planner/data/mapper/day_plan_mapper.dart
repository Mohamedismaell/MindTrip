import 'package:mindtrip/features/ai_planner/data/mapper/plan_place_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/day_plan_entity.dart';

extension DayPlanModelMapper on DayPlanModel {
  DayPlanEntity toEntity() {
    return DayPlanEntity(
      morning: morning.map((e) => e.toEntity()).toList(),
      afternoon: afternoon.map((e) => e.toEntity()).toList(),
      evening: evening.map((e) => e.toEntity()).toList(),
    );
  }
}

extension DayPlanEntityMapper on DayPlanEntity {
  DayPlanModel toModel() {
    return DayPlanModel(
      morning: morning.map((e) => e.toModel()).toList(),
      afternoon: afternoon.map((e) => e.toModel()).toList(),
      evening: evening.map((e) => e.toModel()).toList(),
    );
  }
}
