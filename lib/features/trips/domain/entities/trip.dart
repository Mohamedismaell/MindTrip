import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/trip_cover_assets.dart';

enum TripStatus { draft, inProgress, completed }

class Trip extends Equatable {
  final String id;
  final String title;
  final TripStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Domain data
  final String destination;
  final DateTime? tripStart;
  final DateTime? tripEnd;
  final int adults;
  final int children;
  final int pets;
  final String? budgetTier;
  final String customBudget;
  final List<String> interests;

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
      itineraryCoverUrl: itineraryCoverUrl ?? this.itineraryCoverUrl,
      placePreviews: placePreviews ?? this.placePreviews,
    );
  }

  double get planningProgress {
    if (status != TripStatus.draft) return 1.0;

    // Calculate progress based on presence of data steps
    double progress = 0.2; // Step 0: Destination (always present for a draft)
    if (tripStart != null) progress = 0.4; // Step 1: Dates
    if (adults > 0 || children > 0 || pets > 0) {
      progress = 0.6; // Step 2: Travelers
    }
    if ((budgetTier != null && budgetTier!.isNotEmpty) ||
        customBudget.isNotEmpty) {
      progress = 0.8; // Step 3: Budget
    }
    if (interests.isNotEmpty) progress = 1.0; // Step 4: Interests

    return progress;
  }

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
  ];
}
