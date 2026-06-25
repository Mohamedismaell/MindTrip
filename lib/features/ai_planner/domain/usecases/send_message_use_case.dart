import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  const SendMessageUseCase(this.repository);

  final ChatRepository repository;

  Future<ChatMessage> call(
    String message, {
    required String sessionId,
    CollectedPlannerData? collected,
  }) {
    return repository.sendMessage(
      message,
      sessionId: sessionId,
      collected: collected,
    );
  }
}
