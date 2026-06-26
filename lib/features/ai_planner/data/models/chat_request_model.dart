import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_collected_data_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data.dart';

part 'chat_request_model.freezed.dart';
part 'chat_request_model.g.dart';

@freezed
abstract class ChatRequestModel with _$ChatRequestModel {
  const factory ChatRequestModel({
    required String sessionId,
    required String message,
    required ChatCollectedDataModel collected,
    required ChatCollectedDataModel cardAnswers,
  }) = _ChatRequestModel;

  factory ChatRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestModelFromJson(json);

  factory ChatRequestModel.fromCollected({
    required String sessionId,
    required String message,
    CollectedPlannerData? collected,
  }) {
    final collectedModel = collected == null
        ? ChatCollectedDataModel.empty()
        : ChatCollectedDataModel.fromEntity(collected);
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
      'collected': collected.toJson(),
      'cardAnswers': cardAnswers.toCardAnswersJson(),
    };
  }
}
