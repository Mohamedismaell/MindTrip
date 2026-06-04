import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

class PlanningSession extends Equatable {
  final String id;
  final int currentPage;
  final List<ChatMessage> chatMessages;
  final DateTime updatedAt;

  const PlanningSession({
    required this.id,
    this.currentPage = 0,
    this.chatMessages = const [],
    required this.updatedAt,
  });

  PlanningSession copyWith({
    String? id,
    int? currentPage,
    List<ChatMessage>? chatMessages,
    DateTime? updatedAt,
  }) {
    return PlanningSession(
      id: id ?? this.id,
      currentPage: currentPage ?? this.currentPage,
      chatMessages: chatMessages ?? this.chatMessages,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, currentPage, chatMessages, updatedAt];
}
