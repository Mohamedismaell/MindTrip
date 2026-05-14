import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

abstract class ChatRepository {
  Future<ChatMessage> sendMessage(String message);

  //! test
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
}
