import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

enum ChatStatus { initial, loaded, error }

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.status = ChatStatus.initial,
    this.isAiTyping = false,
    this.errorMessage,
    this.attachments = const [],
  });

  final List<ChatMessage> messages;
  final ChatStatus status;
  final bool isAiTyping;
  final String? errorMessage;
  final List<ChatAttachment> attachments;
  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatStatus? status,
    bool? isAiTyping,
    String? errorMessage,
    bool clearError = false,
    List<ChatAttachment>? attachments,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      attachments: attachments ?? this.attachments,
    );
  }

  factory ChatState.fromJson(Map<String, dynamic> json) {
    return ChatState(
      messages: (json['messages'] as List<dynamic>? ?? [])
          .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: ChatStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ChatStatus.initial,
      ),
      isAiTyping: false,
      errorMessage: null,
    );
  }

  Map<String, dynamic> toJson() => {
    'messages': messages.map((m) => m.toJson()).toList(),
    'status': status.name,
  };

  @override
  List<Object?> get props => [
    messages,
    status,
    isAiTyping,
    errorMessage,
    attachments,
  ];
}
