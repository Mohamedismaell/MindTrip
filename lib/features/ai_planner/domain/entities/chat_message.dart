import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_attachment.dart';

enum MessageSender { user, ai }

enum AttachmentType { image, video, file }

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.suggestions,
    this.attachments,
    this.isReadyToGenerate = false,
    this.isError = false,
  });

  final String id;
  final String content;
  final MessageSender sender;
  final DateTime timestamp;
  final List<String>? suggestions;

  final List<ChatAttachment>? attachments;
  final bool isReadyToGenerate;
  final bool isError;

  bool get isUser => sender == MessageSender.user;
  bool get isAi => sender == MessageSender.ai;
  bool get hasSuggestions => suggestions != null && suggestions!.isNotEmpty;
  bool get hasAttachments => attachments != null && attachments!.isNotEmpty;

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'sender': sender.name,
    'timestamp': timestamp.millisecondsSinceEpoch,
    if (suggestions != null) 'suggestions': suggestions,
    if (attachments != null)
      'attachments': attachments!.map((a) => a.toJson()).toList(),
    'is_ready_to_generate': isReadyToGenerate,
    'is_error': isError,
  };

  @override
  List<Object?> get props => [
    id,
    content,
    sender,
    timestamp,
    suggestions,
    attachments,
    isReadyToGenerate,
    isError,
  ];
}
