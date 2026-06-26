import 'package:mindtrip/features/ai_planner/data/models/chat_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_response.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  const SendMessageUseCase(this.repository);

  final ChatRepository repository;

  Future<ChatResponse> call(ChatRequestModel request) {
    return repository.sendMessage(request);
  }
}
