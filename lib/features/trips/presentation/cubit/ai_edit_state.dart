import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/edit_plan_response_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

part 'ai_edit_state.freezed.dart';

enum AiEditStatus { initial, loading, success, failure }

@freezed
abstract class AiEditState with _$AiEditState {
  const factory AiEditState({
    @Default(AiEditStatus.initial) AiEditStatus status,
    @Default([]) List<ChatMessage> messages,
    GeneratedPlanEntity? currentPlan,
    EditPlanResponseEntity? lastAIResponse,
    @Default('') String errorMessage,
    String? tripId,
  }) = _AiEditState;
}
