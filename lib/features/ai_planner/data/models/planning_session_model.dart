import 'package:mindtrip/features/ai_planner/domain/entities/planning_session.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_message_model.dart';

class PlanningSessionModel extends PlanningSession {
  const PlanningSessionModel({
    required super.id,
    super.currentPage = 0,
    super.chatMessages = const [],
    required super.updatedAt,
  });

  factory PlanningSessionModel.fromJson(Map<String, dynamic> json) {
    return PlanningSessionModel(
      id: json['id'],
      currentPage: json['currentPage'] ?? 0,
      chatMessages: (json['chatMessages'] as List?)
              ?.map((e) => ChatMessageModel.fromJson(e).toEntity())
              .toList() ??
          const [],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currentPage': currentPage,
      'chatMessages': chatMessages
          .map((e) => ChatMessageModel.fromEntity(e).toJson())
          .toList(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory PlanningSessionModel.fromEntity(PlanningSession entity) {
    return PlanningSessionModel(
      id: entity.id,
      currentPage: entity.currentPage,
      chatMessages: entity.chatMessages,
      updatedAt: entity.updatedAt,
    );
  }
}
