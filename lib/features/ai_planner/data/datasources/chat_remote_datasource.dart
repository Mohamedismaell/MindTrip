import 'dart:math';

import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_message_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_request_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_response_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_response.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data.dart';

abstract class ChatRemoteDataSource {
  Future<ChatResponse> sendMessage(ChatRequestModel request);

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

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl({required ApiConsumer apiConsumer})
    : _api = apiConsumer;

  final ApiConsumer _api;
  final _random = Random();

  String _generateId() =>
      'msg_${DateTime.now().millisecondsSinceEpoch}_${_random.nextInt(9999)}';

  @override
  Future<ChatResponse> sendMessage(ChatRequestModel request) async {
    try {
      final response = await _api.post(
        EndPoints.aiChat,
        data: request.toJson(),
      );
      return _parseResponse(response);
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  ChatResponse _parseResponse(dynamic response) {
    if (response is String) {
      return ChatResponse(
        status: 'chat',
        output: response,
        collected: const CollectedPlannerData(),
        missing: const [],
      );
    }

    if (response is Map<String, dynamic>) {
      return ChatResponseModel.fromJson(response).toEntity();
    }

    return ChatResponse(
      status: 'chat',
      output: response?.toString() ?? '',
      collected: const CollectedPlannerData(),
      missing: const [],
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
    final interestsList = interests.join(', ');
    final content =
        'Here is your trip summary:\n\n'
        'Destination: $destination\n'
        'Dates: $startDate -> $endDate\n'
        'Travelers: $adults adult${adults != 1 ? 's' : ''}'
        '${children > 0 ? ', $children child${children != 1 ? 'ren' : ''}' : ''}\n'
        'Budget: $budget\n'
        'Interests: $interestsList\n\n'
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
