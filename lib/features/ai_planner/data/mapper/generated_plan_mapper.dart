import '../models/generated_plan_model.dart';
import '../models/plan_model.dart';
import '../../domain/entities/generated_plan_entity.dart';

extension GeneratedPlanModelMapper on GeneratedPlanModel {
  GeneratedPlanEntity toEntity() {
    final planData = plan;
    return GeneratedPlanEntity(
      tripId: tripId,
      status: status,
      people: people,
      totalCalculatedCost: totalCalculatedCost,
      daysCount: daysCount,
      accommodation:
          planData?.accommodation.map((e) => e.toEntity()).toList() ?? [],
      days:
          planData?.days.map((key, value) => MapEntry(key, value.toEntity())) ??
          {},
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
      plan: PlanModel(
        accommodation: accommodation.map((e) => e.toModel()).toList(),
        days: days.map((key, value) => MapEntry(key, value.toModel())),
      ),
    );
  }
}
