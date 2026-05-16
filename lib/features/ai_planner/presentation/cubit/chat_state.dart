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
    this.isReadyToGenerate = false,
    this.tripMetadata,
  });

  final List<ChatMessage> messages;
  final ChatStatus status;
  final bool isAiTyping;
  final String? errorMessage;
  final List<ChatAttachment> attachments;

  final bool isReadyToGenerate;
  final Map<String, dynamic>? tripMetadata;
  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatStatus? status,
    bool? isAiTyping,
    String? errorMessage,
    bool clearError = false,
    List<ChatAttachment>? attachments,
    bool? isReadyToGenerate,
    Map<String, dynamic>? tripMetadata,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      attachments: attachments ?? this.attachments,
      isReadyToGenerate: isReadyToGenerate ?? this.isReadyToGenerate,
      tripMetadata: tripMetadata ?? this.tripMetadata,
    );
  }

  @override
  List<Object?> get props => [
    messages,
    status,
    isAiTyping,
    errorMessage,
    attachments,
    isReadyToGenerate,
    tripMetadata,
  ];
}
