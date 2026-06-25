import 'package:mindtrip/features/ai_planner/data/datasources/chat_remote_datasource.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl({required this.dataSource});

  final ChatRemoteDataSource dataSource;

  @override
  Future<ChatMessage> sendMessage(
    String message, {
    required String sessionId,
    CollectedPlannerData? collected,
  }) async {
    final model = await dataSource.sendMessage(
      message,
      sessionId: sessionId,
      collected: collected,
    );
    return model.toEntity();
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
