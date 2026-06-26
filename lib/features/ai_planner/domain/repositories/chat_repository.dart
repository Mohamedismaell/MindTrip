import 'package:mindtrip/features/ai_planner/data/models/chat_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_response.dart';

abstract class ChatRepository {
  Future<ChatResponse> sendMessage(ChatRequestModel request);

  ChatMessage generateTripSummary({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required int adults,
    required int children,
    required int pets,
    required String budget,
    required List<String> interests,
  });
}
