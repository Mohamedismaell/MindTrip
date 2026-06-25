import 'package:mindtrip/features/ai_planner/data/mapper/day_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/plan_place_mapper.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

import '../models/generated_plan_model.dart';

extension GeneratedPlanModelMapper on GeneratedPlanModel {
  GeneratedPlanEntity toEntity() {
    return GeneratedPlanEntity(
      tripId: tripId,
      status: status,
      people: people,
      totalCalculatedCost: totalCalculatedCost,
      daysCount: daysCount,
      accommodation: accommodation.map((e) => e.toEntity()).toList(),
      days: days.map((key, value) => MapEntry(key, value.toEntity())),
    );
  }
}

extension GeneratedPlanEntityMapper on GeneratedPlanEntity {
  GeneratedPlanModel toModel() {
    return GeneratedPlanModel(
      tripId: tripId,
      status: status,
      people: people,
      totalCalculatedCost: totalCalculatedCost,
      daysCount: daysCount,
      accommodation: accommodation.map((e) => e.toModel()).toList(),
      days: days.map((key, value) => MapEntry(key, value.toModel())),
    );
  }
}
