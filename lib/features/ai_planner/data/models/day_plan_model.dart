import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';

part 'day_plan_model.freezed.dart';
part 'day_plan_model.g.dart';

enum PlaceDayPeriod { morning, afternoon, evening }

@freezed
abstract class DayPlanModel with _$DayPlanModel {
  const DayPlanModel._();

  const factory DayPlanModel({
    @JsonKey(fromJson: _parsePlaces) @Default([]) List<PlanPlaceModel> morning,

    @JsonKey(fromJson: _parsePlaces)
    @Default([])
    List<PlanPlaceModel> afternoon,

    @JsonKey(fromJson: _parsePlaces) @Default([]) List<PlanPlaceModel> evening,
  }) = _DayPlanModel;
  List<PlanPlaceModel> get allPlaces => [...morning, ...afternoon, ...evening];

  factory DayPlanModel.fromJson(Map<String, dynamic> json) =>
      _$DayPlanModelFromJson(json);
}

List<PlanPlaceModel> _parsePlaces(dynamic value) {
  if (value is! List) return [];

  return value
      .whereType<Map<String, dynamic>>() // removes nulls
      .map(PlanPlaceModel.fromJson)
      .toList();
}
