import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

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
