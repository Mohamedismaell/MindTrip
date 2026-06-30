import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';

part 'edit_plan_request_model.freezed.dart';
part 'edit_plan_request_model.g.dart';

@freezed
abstract class EditPlanRequestModel with _$EditPlanRequestModel {
  const factory EditPlanRequestModel({
    @JsonKey(name: 'targetChange') required String targetChange,
    required String destination,
    required String city,
    required int days,
    required int budget,
    required int people,
    required List<String> interests,
    @JsonKey(name: 'existingPlan') required List<PlanPlaceModel> existingPlan,
    @Default([]) List<PlanPlaceModel> places,
    @Default([]) List<ConversationTurnModel> conversation,
    @JsonKey(name: 'tripId') String? tripId,
    @JsonKey(name: 'mustInclude') List<String>? mustInclude,
    @JsonKey(name: 'mode') String? mode,
    @JsonKey(name: 'item') ItemToEdit? item,
  }) = _EditPlanRequestModel;

  factory EditPlanRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditPlanRequestModelFromJson(json);
}

@freezed
abstract class ItemToEdit with _$ItemToEdit {
  const factory ItemToEdit({
    @JsonKey(name: 'place_id') String? placeId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'day') int? day,
    @JsonKey(name: 'slot') String? slot,
  }) = _ItemToEdit;

  factory ItemToEdit.fromJson(Map<String, dynamic> json) =>
      _$ItemToEditFromJson(json);
}

@freezed
abstract class ConversationTurnModel with _$ConversationTurnModel {
  const factory ConversationTurnModel({
    required String role,
    required String content,
  }) = _ConversationTurnModel;

  factory ConversationTurnModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationTurnModelFromJson(json);
}
