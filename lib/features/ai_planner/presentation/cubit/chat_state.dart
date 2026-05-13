import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

enum ChatStatus { initial, loaded, error }

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.status = ChatStatus.initial,
    this.isAiTyping = false,
    this.errorMessage,
  });

  final List<ChatMessage> messages;
  final ChatStatus status;
  final bool isAiTyping;
  final String? errorMessage;

  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatStatus? status,
    bool? isAiTyping,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [messages, status, isAiTyping, errorMessage];
}
