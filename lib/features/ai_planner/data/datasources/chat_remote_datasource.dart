import 'dart:math';

import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_message_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data.dart';

/// Abstract interface for the chat data source.
abstract class ChatRemoteDataSource {
  Future<ChatMessageModel> sendMessage(
    String message, {
    required String sessionId,
    CollectedPlannerData? collected,
  });

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

/// Real implementation — calls POST /api/v1/ai/chat.
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl({required ApiConsumer apiConsumer})
    : _api = apiConsumer;

  final ApiConsumer _api;
  final _random = Random();

  String _generateId() =>
      'msg_${DateTime.now().millisecondsSinceEpoch}_${_random.nextInt(9999)}';

  @override
  Future<ChatMessageModel> sendMessage(
    String message, {
    required String sessionId,
    CollectedPlannerData? collected,
  }) async {
    try {
      final body = <String, dynamic>{
        'sessionId': sessionId,
        'message': message,
      };

      if (collected != null) {
        final collectedMap = collected.toCollectedMap();
        if (collectedMap.isNotEmpty) {
          body['collected'] = collectedMap;
          body['cardAnswers'] = collected.toCardAnswersMap();
        }
      }

      final response = await _api.post(EndPoints.aiChat, data: body);
      return _parseResponse(response);
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  ChatMessageModel _parseResponse(dynamic response) {
    // Backend may return a plain string or a JSON object.
    String content;
    bool isReady = false;
    List<String>? suggestions;

    if (response is String) {
      content = response;
    } else if (response is Map<String, dynamic>) {
      content =
          (response['message'] ??
                  response['reply'] ??
                  response['content'] ??
                  '')
              .toString();
      isReady = response['isReadyToGenerate'] as bool? ?? false;
      final rawSuggestions = response['suggestions'];
      if (rawSuggestions is List) {
        suggestions = rawSuggestions.map((e) => e.toString()).toList();
      }
    } else {
      content = response?.toString() ?? '';
    }

    return ChatMessageModel(
      id: _generateId(),
      content: content,
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
      suggestions: suggestions,
      isReadyToGenerate: isReady,
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
    // Trip summary is generated locally — no backend call needed.
    final interestsList = interests.join(', ');
    final content =
        '🗺️ Here\'s your trip summary:\n\n'
        '📍 Destination: $destination\n'
        '📅 Dates: $startDate → $endDate\n'
        '👥 Travelers: $adults adult${adults != 1 ? 's' : ''}'
        '${children > 0 ? ', $children child${children != 1 ? 'ren' : ''}' : ''}\n'
        '💰 Budget: $budget\n'
        '🎯 Interests: $interestsList\n\n'
        'Ready to generate your personalized itinerary!';

    return ChatMessageModel(
      id: _generateId(),
      content: content,
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
      isReadyToGenerate: true,
    );
  }
}
