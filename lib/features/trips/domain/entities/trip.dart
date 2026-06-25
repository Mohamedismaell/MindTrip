import 'package:equatable/equatable.dart';

enum TripStatus { draft, inProgress, completed, upcoming, cancelled }

class Trip extends Equatable {
  final String id;
  final String title;
  final TripStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Domain data
  final String destination;
  final String? destinationGovernorate;
  final DateTime? tripStart;
  final DateTime? tripEnd;
  final int people;
  final int totalBudget;
  final int totalCost;
  final List<String> interests;

  final String? coverImageUrl;
  final String? sessionId;
  final String? backendTripId;
  final String? planJson;
  final String? collectedJson;

  final String? shareToken;
  final bool isPublic;
  final int placesCount;
  final double progressPercent;

  const Trip({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.destination,
    this.destinationGovernorate,
    this.tripStart,
    this.tripEnd,
    required this.people,
    this.totalBudget = 0,
    this.totalCost = 0,
    required this.interests,
    this.coverImageUrl,
    this.sessionId,
    this.backendTripId,
    this.planJson,
    this.collectedJson,
    this.shareToken,
    this.isPublic = false,
    this.placesCount = 0,
    this.progressPercent = 0,
  });

  Trip copyWith({
    String? id,
    String? title,
    TripStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? destination,
    String? destinationGovernorate,
    DateTime? tripStart,
    DateTime? tripEnd,
    int? people,
    int? totalBudget,
    int? totalCost,
    List<String>? interests,
    String? coverImageUrl,
    String? sessionId,
    String? backendTripId,
    String? planJson,
    String? collectedJson,
    String? shareToken,
    bool? isPublic,
    int? placesCount,
    double? progressPercent,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      destination: destination ?? this.destination,
      destinationGovernorate:
          destinationGovernorate ?? this.destinationGovernorate,
      tripStart: tripStart ?? this.tripStart,
      tripEnd: tripEnd ?? this.tripEnd,
      people: people ?? this.people,
      totalBudget: totalBudget ?? this.totalBudget,
      totalCost: totalCost ?? this.totalCost,
      interests: interests ?? this.interests,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      sessionId: sessionId ?? this.sessionId,
      backendTripId: backendTripId ?? this.backendTripId,
      planJson: planJson ?? this.planJson,
      collectedJson: collectedJson ?? this.collectedJson,
      shareToken: shareToken ?? this.shareToken,
      isPublic: isPublic ?? this.isPublic,
      placesCount: placesCount ?? this.placesCount,
      progressPercent: progressPercent ?? this.progressPercent,
    );
  }

  double get planningProgress {
    if (status != TripStatus.draft) return 1.0;

    // Calculate progress based on presence of data steps
    double progress = 0.2; // Step 0: Destination
    if (tripStart != null) progress = 0.4; // Step 1: Dates
    if (people > 0) progress = 0.6; // Step 2: Travelers
    if (totalBudget > 0) progress = 0.8; // Step 3: Budget
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

  // String get coverAsset => TripCoverAssets.getForCity(destination);

  @override
  List<Object?> get props => [
    id,
    title,
    status,
    createdAt,
    updatedAt,
    destination,
    destinationGovernorate,
    tripStart,
    tripEnd,
    people,
    totalBudget,
    totalCost,
    interests,
    coverImageUrl,
    sessionId,
    backendTripId,
    planJson,
    collectedJson,
    shareToken,
    isPublic,
    placesCount,
    progressPercent,
  ];
}
