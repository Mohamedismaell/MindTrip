import 'package:mindtrip/features/ai_planner/data/mapper/plan_place_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

extension GeneratedPlanToModelsMapper on GeneratedPlanEntity {
  List<PlanPlaceModel> toModels() {
    final List<PlanPlaceModel> models = [];

    // Add accommodation as day 0
    for (final place in accommodation) {
      models.add(place.toModel().copyWith(day: 0));
    }

    // Add places from each day
    days.forEach((dayNumber, dayPlan) {
      for (final place in dayPlan.allPlaces) {
        models.add(place.toModel().copyWith(day: dayNumber));
      }
    });

    return models;
  }
}
