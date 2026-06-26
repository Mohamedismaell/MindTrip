import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_attachment.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_response.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
part 'chat_state.freezed.dart';

enum ChatStatus { initial, loaded, error }

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<ChatMessage> messages,
    @Default(ChatStatus.initial) ChatStatus status,
    @Default(false) bool isAiTyping,
    String? errorMessage,
    @Default([]) List<ChatAttachment> attachments,

    ChatResponse? lastResponse,
  }) = _ChatState;
}

extension ChatStateX on ChatState {
  bool get isReadyToGenerate => lastResponse?.isReadyToGenerate ?? false;

  CollectedPlannerDataEntity get collected =>
      lastResponse?.collected ?? const CollectedPlannerDataEntity();

  List<String> get missing => lastResponse?.missing ?? const [];

  String get aiOutput => lastResponse?.output ?? '';
}
