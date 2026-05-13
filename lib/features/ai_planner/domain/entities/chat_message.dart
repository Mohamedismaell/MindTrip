import 'package:equatable/equatable.dart';

enum MessageSender { user, ai }

class ChatMessage extends Equatable {
  const ChatMessage({
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

  bool get isUser => sender == MessageSender.user;
  bool get isAi => sender == MessageSender.ai;
  bool get hasSuggestions =>
      suggestions != null && suggestions!.isNotEmpty;

  @override
  List<Object?> get props => [id, content, sender, timestamp, suggestions];
}
