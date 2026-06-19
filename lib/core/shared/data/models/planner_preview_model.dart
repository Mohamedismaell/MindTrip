import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'planner_preview_model.freezed.dart';
part 'planner_preview_model.g.dart';

@freezed
abstract class PlannerStopModel with _$PlannerStopModel {
  @HiveType(typeId: 12)
  const factory PlannerStopModel({
    @HiveField(0) required String time,
    @HiveField(1) required String label,
  }) = _PlannerStopModel;

  const PlannerStopModel._();

  factory PlannerStopModel.fromJson(Map<String, dynamic> json) =>
      _$PlannerStopModelFromJson(json);
}

@freezed
abstract class PlannerPreviewModel with _$PlannerPreviewModel {
  @HiveType(typeId: 13)
  const factory PlannerPreviewModel({
    @HiveField(0) required String title,
    @HiveField(1) required String imageUrl,
    @HiveField(2) required List<PlannerStopModel> stops,
    @HiveField(3) required String badge,
  }) = _PlannerPreviewModel;

  const PlannerPreviewModel._();

  factory PlannerPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$PlannerPreviewModelFromJson(json);
}
