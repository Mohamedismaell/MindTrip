import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/trip_cover_assets.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

enum TripStatus { draft, inProgress, completed }

class Trip extends Equatable {
  final String id;
  final String title;
  final TripStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Planner flow snapshot
  final String destination;
  final DateTime? tripStart;
  final DateTime? tripEnd;
  final int adults;
  final int children;
  final int pets;
  final String? budgetTier;
  final String customBudget;
  final List<String> interests;
  final int currentPage; // 0-4

  final List<ChatMessage> chatMessages;

  final String? itineraryCoverUrl;
  final List<Map<String, String>> placePreviews; // [{name, imageUrl}]

  const Trip({
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
    required this.chatMessages,
    this.itineraryCoverUrl,
    this.placePreviews = const [],
  });

  Trip copyWith({
    String? id,
    String? title,
    TripStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? destination,
    DateTime? tripStart,
    DateTime? tripEnd,
    int? adults,
    int? children,
    int? pets,
    String? budgetTier,
    String? customBudget,
    List<String>? interests,
    int? currentPage,
    List<ChatMessage>? chatMessages,
    String? itineraryCoverUrl,
    List<Map<String, String>>? placePreviews,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      destination: destination ?? this.destination,
      tripStart: tripStart ?? this.tripStart,
      tripEnd: tripEnd ?? this.tripEnd,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      pets: pets ?? this.pets,
      budgetTier: budgetTier ?? this.budgetTier,
      customBudget: customBudget ?? this.customBudget,
      interests: interests ?? this.interests,
      currentPage: currentPage ?? this.currentPage,
      chatMessages: chatMessages ?? this.chatMessages,
      itineraryCoverUrl: itineraryCoverUrl ?? this.itineraryCoverUrl,
      placePreviews: placePreviews ?? this.placePreviews,
    );
  }

  double get planningProgress => currentPage / 5;
  //Todo how dow e know the porogress of the trip ??!!??
  double get tripProgress {
    if (tripStart == null || tripEnd == null) return 0.0;
    final totalDays = tripEnd!.difference(tripStart!).inDays + 1;
    if (totalDays <= 0) return 0.0;
    final elapsed = DateTime.now().difference(tripStart!).inDays + 1;
    return (elapsed / totalDays).clamp(0.0, 1.0);
  }

  int get daysRemaining {
    if (tripEnd == null) return 0;
    final remaining = tripEnd!.difference(DateTime.now()).inDays;
    return remaining < 0 ? 0 : remaining;
  }

  int get remainingStep => (5 - currentPage);

  int get durationDays {
    if (tripStart == null || tripEnd == null) return 0;
    return tripEnd!.difference(tripStart!).inDays + 1;
  }

  String get coverAsset => TripCoverAssets.getForCity(destination);

  @override
  List<Object?> get props => [
    id,
    title,
    status,
    createdAt,
    updatedAt,
    destination,
    tripStart,
    tripEnd,
    adults,
    children,
    pets,
    budgetTier,
    customBudget,
    interests,
    currentPage,
    chatMessages,
    itineraryCoverUrl,
    placePreviews,
  ];
}
