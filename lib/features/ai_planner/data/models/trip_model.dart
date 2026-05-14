import 'dart:convert';
import 'package:hive_ce/hive.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 5)
class TripModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final DateTime updatedAt;

  @HiveField(5)
  final String destination;

  @HiveField(6)
  final DateTime? tripStart;

  @HiveField(7)
  final DateTime? tripEnd;

  @HiveField(8)
  final int adults;

  @HiveField(9)
  final int children;

  @HiveField(10)
  final int pets;

  @HiveField(11)
  final String? budgetTier;

  @HiveField(12)
  final String customBudget;

  @HiveField(13)
  final List<String> interests;

  @HiveField(14)
  final int currentPage;

  @HiveField(15)
  final String chatMessagesJson;

  TripModel({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.destination,
    this.tripStart,
    this.tripEnd,
    required this.adults,
    required this.children,
    required this.pets,
    this.budgetTier,
    required this.customBudget,
    required this.interests,
    required this.currentPage,
    required this.chatMessagesJson,
  });

  factory TripModel.fromEntity(Trip trip) {
    return TripModel(
      id: trip.id,
      title: trip.title,
      status: trip.status.name,
      createdAt: trip.createdAt,
      updatedAt: trip.updatedAt,
      destination: trip.destination,
      tripStart: trip.tripStart,
      tripEnd: trip.tripEnd,
      adults: trip.adults,
      children: trip.children,
      pets: trip.pets,
      budgetTier: trip.budgetTier,
      customBudget: trip.customBudget,
      interests: trip.interests,
      currentPage: trip.currentPage,
      chatMessagesJson: jsonEncode(trip.chatMessages.map((e) => e.toJson()).toList()),
    );
  }

  Trip toEntity() {
    List<ChatMessage> parsedMessages = [];
    if (chatMessagesJson.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(chatMessagesJson);
        parsedMessages = decoded.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>)).toList();
      } catch (e) {
        // Fallback for empty or corrupt chat history
      }
    }

    return Trip(
      id: id,
      title: title,
      status: TripStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => TripStatus.draft,
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
      destination: destination,
      tripStart: tripStart,
      tripEnd: tripEnd,
      adults: adults,
      children: children,
      pets: pets,
      budgetTier: budgetTier,
      customBudget: customBudget,
      interests: interests,
      currentPage: currentPage,
      chatMessages: parsedMessages,
    );
  }
}
