import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  const SendMessageUseCase({required this.repository});

  final ChatRepository repository;

  Future<ChatMessage> call(String message) {
    return repository.sendMessage(message);
  }
}
