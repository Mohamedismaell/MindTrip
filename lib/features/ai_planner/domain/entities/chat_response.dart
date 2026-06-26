import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data.dart';

class ChatResponse extends Equatable {
  const ChatResponse({
    required this.status,
    required this.output,
    required this.collected,
    required this.missing,
  });

  final String status;
  final String output;
  final CollectedPlannerData collected;
  final List<String> missing;

  bool get isReadyToGenerate => missing.isEmpty;

  ChatMessage toChatMessage({required String id, required DateTime timestamp}) {
    return ChatMessage(
      id: id,
      content: output,
      sender: MessageSender.ai,
      timestamp: timestamp,
      isReadyToGenerate: isReadyToGenerate,
    );
  }

  @override
  List<Object?> get props => [status, output, collected, missing];
}
