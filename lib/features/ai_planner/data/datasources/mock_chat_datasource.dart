import 'dart:math';

import 'package:mindtrip/features/ai_planner/data/datasources/chat_mock_responses.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_message_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

//! sending message will not need all the i think.........
/// Abstract interface for the chat data source.
/// Swap [MockChatDataSource] with a real implementation when API is ready.
abstract class ChatDataSource {
  Future<ChatMessageModel> sendMessage(String message);

  ChatMessageModel getTripSummary({
    required String destination,
    required String startDate,
    required String endDate,
    required int adults,
    required int children,
    required int pets,
    required String budget,
    required List<String> interests,
  });
}

/// Mock implementation that simulates AI responses with delays.
class MockChatDataSource implements ChatDataSource {
  final _random = Random();

  String _generateId() =>
      'msg_${DateTime.now().millisecondsSinceEpoch}_${_random.nextInt(9999)}';

  @override
  Future<ChatMessageModel> sendMessage(String message) async {
    await Future<void>.delayed(
      Duration(milliseconds: 1000 + _random.nextInt(1000)),
    );

    final response = _matchResponse(message.toLowerCase());

    return ChatMessageModel(
      id: _generateId(),
      content: response.content,
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
      suggestions: null,
    );
  }

  @override
  ChatMessageModel getTripSummary({
    required String destination,
    required String startDate,
    required String endDate,
    required int adults,
    required int children,
    required int pets,
    required String budget,
    required List<String> interests,
  }) {
    return ChatMessageModel(
      id: _generateId(),
      content: ChatMockResponses.tripSummary(
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        adults: adults,
        children: children,
        pets: pets,
        budget: budget,
        interests: interests,
      ),
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
    );
  }

  /// Matches user input keywords to response categories.
  _MatchedResponse _matchResponse(String input) {
    for (final entry in ChatMockResponses.keywordMap.entries) {
      final category = entry.key;
      final keywords = entry.value;

      for (final keyword in keywords) {
        if (input.contains(keyword)) {
          final categoryResponses = ChatMockResponses.responses[category]!;
          final response =
              categoryResponses[_random.nextInt(categoryResponses.length)];
          return _MatchedResponse(content: response);
        }
      }
    }

    // Fallback to general response
    final generalResponses = ChatMockResponses.responses['general']!;
    return _MatchedResponse(
      content: generalResponses[_random.nextInt(generalResponses.length)],
    );
  }
}

class _MatchedResponse {
  const _MatchedResponse({required this.content});
  final String content;
}
