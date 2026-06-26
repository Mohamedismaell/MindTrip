import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';

part 'chat_request_model.freezed.dart';
part 'chat_request_model.g.dart';

@freezed
abstract class ChatRequestModel with _$ChatRequestModel {
  const factory ChatRequestModel({
    required String sessionId,
    required String message,
    required CollectedDataModel collected,
    required CollectedDataModel cardAnswers,
  }) = _ChatRequestModel;

  factory ChatRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestModelFromJson(json);

  factory ChatRequestModel.fromCollected({
    required String sessionId,
    required String message,
    CollectedPlannerDataEntity? collected,
  }) {
    final collectedModel = collected == null
        ? CollectedDataModel.empty()
        : CollectedDataModel.fromEntity(collected);
    return ChatRequestModel(
      sessionId: sessionId,
      message: message,
      collected: collectedModel,
      cardAnswers: collectedModel,
    );
  }
}

extension ChatRequestModelJson on ChatRequestModel {
  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'message': message,
      'collected': collected,
      'cardAnswers': cardAnswers,
    };
  }
}
