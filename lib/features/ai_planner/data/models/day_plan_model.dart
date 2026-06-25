import 'package:freezed_annotation/freezed_annotation.dart';
import 'plan_place_model.dart';

part 'day_plan_model.freezed.dart';
part 'day_plan_model.g.dart';

@freezed
abstract class DayPlanModel with _$DayPlanModel {
  const factory DayPlanModel({
    @Default(<PlanPlaceModel>[]) List<PlanPlaceModel> morning,

    @Default(<PlanPlaceModel>[]) List<PlanPlaceModel> afternoon,

    @Default(<PlanPlaceModel>[]) List<PlanPlaceModel> evening,
  }) = _DayPlanModel;

  factory DayPlanModel.fromJson(Map<String, dynamic> json) =>
      _$DayPlanModelFromJson(json);
}
