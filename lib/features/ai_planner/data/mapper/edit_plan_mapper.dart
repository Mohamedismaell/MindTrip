import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/plan_place_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/models/edit_plan_response_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/edit_plan_response_entity.dart';

extension EditPlanResponseModelMapper on EditPlanResponseModel {
  EditPlanResponseEntity toEntity() {
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
      plan: plan?.toEntity(),
    );
  }
}
