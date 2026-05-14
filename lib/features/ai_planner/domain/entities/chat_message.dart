import 'package:equatable/equatable.dart';

enum MessageSender { user, ai }

enum AttachmentType { image, video, file }

class ChatAttachment extends Equatable {
  const ChatAttachment({required this.path, required this.type});

  final String path;
  final AttachmentType type;

  factory ChatAttachment.fromJson(Map<String, dynamic> json) {
    return ChatAttachment(
      path: json['path'] as String,
      type: AttachmentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AttachmentType.image,
      ),
    );
  }

  Map<String, dynamic> toJson() => {'path': path, 'type': type.name};

  @override
  List<Object?> get props => [path, type];
}

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.suggestions,
    this.attachments,
  });

  final String id;
  final String content;
  final MessageSender sender;
  final DateTime timestamp;
  final List<String>? suggestions;

  final List<ChatAttachment>? attachments;

  bool get isUser => sender == MessageSender.user;
  bool get isAi => sender == MessageSender.ai;
  bool get hasSuggestions => suggestions != null && suggestions!.isNotEmpty;
  bool get hasAttachments => attachments != null && attachments!.isNotEmpty;

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      content: json['content'] as String,
      sender: MessageSender.values.firstWhere(
        (e) => e.name == json['sender'],
        orElse: () => MessageSender.user,
      ),
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
      suggestions: (json['suggestions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => ChatAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'sender': sender.name,
    'timestamp': timestamp.millisecondsSinceEpoch,
    if (suggestions != null) 'suggestions': suggestions,
    if (attachments != null)
      'attachments': attachments!.map((a) => a.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    id,
    content,
    sender,
    timestamp,
    suggestions,
    attachments,
  ];
}
