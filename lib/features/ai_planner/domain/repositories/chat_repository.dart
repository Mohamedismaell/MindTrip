import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

abstract class ChatRepository {
  /// Sends a user message and returns the AI's response.
  Future<ChatMessage> sendMessage(String message);



  /// Returns a trip summary message based on planner selections.
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

  /// Returns a retry suggestion message after plan generation failure.
  ChatMessage getRetryMessage();
}
