import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data.dart';

abstract class ChatRepository {
  Future<ChatMessage> sendMessage(
    String message, {
    required String sessionId,
    CollectedPlannerData? collected,
  });

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
