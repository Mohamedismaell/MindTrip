import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

extension GeneratedPlanEntityJsonMapper on GeneratedPlanEntity {
  Map<String, dynamic> toJson() {
    return toModel().toJson();
  }
}
