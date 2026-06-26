import 'package:mindtrip/features/ai_planner/data/datasources/chat_remote_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_response.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl({required this.dataSource});

  final ChatRemoteDataSource dataSource;

  @override
  Future<ChatResponse> sendMessage(ChatRequestModel request) async {
    return dataSource.sendMessage(request);
  }

  @override
  ChatMessage generateTripSummary({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required int adults,
    required int children,
    required int pets,
    required String budget,
    required List<String> interests,
  }) {
    String formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

    return dataSource
        .getTripSummary(
          destination: destination,
          startDate: formatDate(startDate),
          endDate: formatDate(endDate),
          adults: adults,
          children: children,
          pets: pets,
          budget: budget,
          interests: interests,
        )
        .toEntity();
  }
}
