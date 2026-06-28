import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/plan_place_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/models/edit_plan_response_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/edit_plan_response_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

extension EditPlanResponseModelMapper on EditPlanResponseModel {
  EditPlanResponseEntity toEntity() {
    final entityPlan = plan?.toEntity();
    final updatedPlan = entityPlan != null
        ? GeneratedPlanEntity(
          tripId: tripId ?? entityPlan.tripId,
          status: status ?? entityPlan.status,
          people: people ?? entityPlan.people,
          totalCalculatedCost:
              totalCalculatedCost?.toInt() ?? entityPlan.totalCalculatedCost,
          daysCount: daysCount ?? entityPlan.daysCount,
          accommodation: entityPlan.accommodation,
          days: entityPlan.days,
        )
        : null;

    return EditPlanResponseEntity(
      mode: mode,
      message: message,
      tripId: tripId,
      status: status,
      changeApplied: changeApplied,
      askForReplacement: askForReplacement,
      insertAfter: insertAfter,
      item: item?.toEntity(),
      people: people,
      totalCalculatedCost: totalCalculatedCost,
      daysCount: daysCount,
      needsReplan: needsReplan,
      plan: updatedPlan,
    );
  }
}
