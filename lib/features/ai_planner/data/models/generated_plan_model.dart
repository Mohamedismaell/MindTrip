import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/utils/json_parser.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_model.dart';

part 'generated_plan_model.freezed.dart';
part 'generated_plan_model.g.dart';

@freezed
abstract class GeneratedPlanModel with _$GeneratedPlanModel {
  const factory GeneratedPlanModel({
    @JsonKey(name: 'trip_id', fromJson: parseString)
    @Default('')
    String tripId,

    @JsonKey(fromJson: parseString) @Default('') String status,

    @JsonKey(fromJson: parseInt) @Default(0) int people,

    @JsonKey(name: 'total_calculated_cost', fromJson: parseInt)
    @Default(0)
    int totalCalculatedCost,

    @JsonKey(name: 'days_count', fromJson: parseInt) @Default(0) int daysCount,

    PlanModel? plan,
  }) = _GeneratedPlanModel;

  factory GeneratedPlanModel.fromJson(Map<String, dynamic> json) =>
      _$GeneratedPlanModelFromJson(json);
}
