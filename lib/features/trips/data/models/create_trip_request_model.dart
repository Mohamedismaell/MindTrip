import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_collected_data_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

part 'create_trip_request_model.freezed.dart';
part 'create_trip_request_model.g.dart';

@freezed
abstract class CreateTripRequestModel with _$CreateTripRequestModel {
  const factory CreateTripRequestModel({
    required String title,
    required String destinationGovernorate,
    required String city,
    String? startDate,
    String? endDate,
    required int people,
    required int totalBudgetEgp,
    required int totalCost,

    required GeneratedPlanModel plan,

    required CollectedDataModel collected,

    String? sessionId,

    required bool isPublic,

    required int status,
  }) = _CreateTripRequestModel;

  factory CreateTripRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateTripRequestModelFromJson(json);
}
