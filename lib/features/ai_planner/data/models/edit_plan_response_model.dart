import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';

part 'edit_plan_response_model.freezed.dart';
part 'edit_plan_response_model.g.dart';

@freezed
abstract class EditPlanResponseModel with _$EditPlanResponseModel {
  const factory EditPlanResponseModel({
    required String mode,
    String? message,
    @JsonKey(name: 'trip_id') String? tripId,
    String? status,
    @JsonKey(name: 'change_applied') String? changeApplied,
    @JsonKey(name: 'ask_for_replacement') bool? askForReplacement,
    @JsonKey(name: 'insert_after') String? insertAfter,
    PlanPlaceModel? item,
    int? people,
    @JsonKey(name: 'total_calculated_cost') double? totalCalculatedCost,
    @JsonKey(name: 'days_count') int? daysCount,
    @JsonKey(name: 'needs_replan') bool? needsReplan,
    GeneratedPlanModel? plan,
  }) = _EditPlanResponseModel;

  factory EditPlanResponseModel.fromJson(Map<String, dynamic> json) {
    final parsed = _$EditPlanResponseModelFromJson(json);
    if (json['plan'] != null && json['plan'] is Map<String, dynamic>) {
      final innerPlan = json['plan'] as Map<String, dynamic>;
      if (!innerPlan.containsKey('plan')) {
        final generatedPlan = GeneratedPlanModel(
          tripId: json['trip_id']?.toString() ?? '',
          status: json['status']?.toString() ?? '',
          people: json['people'] is num ? (json['people'] as num).toInt() : 0,
          totalCalculatedCost: json['total_calculated_cost'] is num
              ? (json['total_calculated_cost'] as num).toInt()
              : 0,
          daysCount: json['days_count'] is num
              ? (json['days_count'] as num).toInt()
              : 0,
          plan: PlanModel.fromJson(innerPlan),
        );
        return parsed.copyWith(plan: generatedPlan);
      }
    }
    return parsed;
  }
}
