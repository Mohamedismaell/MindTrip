import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_response.dart';

extension ChatResponseMapper on ChatResponse {
  ChatMessage toChatMessage({required String id, required DateTime timestamp}) {
    return ChatMessage(
      id: id,
      content: output,
      sender: MessageSender.ai,
      timestamp: timestamp,
      isReadyToGenerate: isReadyToGenerate,
    );
  }
}
