import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

class ChatMessageModel {
  const ChatMessageModel({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.suggestions,
  });

  final String id;
  final String content;
  final MessageSender sender;
  final DateTime timestamp;
  final List<String>? suggestions;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      content: json['content'] as String,
      sender: json['is_user'] == true ? MessageSender.user : MessageSender.ai,
      timestamp: DateTime.parse(json['timestamp'] as String),
      suggestions: (json['suggestions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_user': sender == MessageSender.user,
      'timestamp': timestamp.toIso8601String(),
      'suggestions': suggestions,
    };
  }

  ChatMessage toEntity() {
    return ChatMessage(
      id: id,
      content: content,
      sender: sender,
      timestamp: timestamp,
      suggestions: suggestions,
    );
  }

  factory ChatMessageModel.fromEntity(ChatMessage entity) {
    return ChatMessageModel(
      id: entity.id,
      content: entity.content,
      sender: entity.sender,
      timestamp: entity.timestamp,
      suggestions: entity.suggestions,
    );
  }
}
