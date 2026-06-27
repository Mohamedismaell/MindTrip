import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

enum TripStatus { draft, inProgress, completed, upcoming, cancelled }

class Trip extends Equatable {
  const Trip({
    required this.tripId,
    required this.title,
    required this.city,
    required this.destinationGovernorate,
    required this.tripStart,
    required this.tripEnd,
    required this.durationDays,
    required this.people,
    required this.totalBudget,
    required this.totalCost,
    required this.status,
    required this.shareToken,
    required this.isPublic,
    required this.sessionId,
    required this.coverImageUrl,
    required this.placesCount,
    required this.progressPercent,
    required this.plan,
    this.collected,
    required this.createdAt,
    required this.updatedAt,
  });

  final String tripId;

  final String title;

  final String city;

  final String destinationGovernorate;

  final DateTime tripStart;

  final DateTime tripEnd;

  final int durationDays;

  final int people;

  final int totalBudget;

  final int totalCost;

  final TripStatus status;

  final String shareToken;

  final bool isPublic;

  final String sessionId;

  final String? coverImageUrl;

  final int placesCount;

  final int progressPercent;

  final GeneratedPlanEntity plan;

  final CollectedPlannerDataEntity? collected;

  final DateTime createdAt;

  final DateTime updatedAt;

  @override
  List<Object?> get props => [
    tripId,
    title,
    city,
    destinationGovernorate,
    tripStart,
    tripEnd,
    durationDays,
    people,
    totalBudget,
    totalCost,
    status,
    shareToken,
    isPublic,
    sessionId,
    coverImageUrl,
    placesCount,
    progressPercent,
    plan,
    collected,
    createdAt,
    updatedAt,
  ];

  Trip copyWith({
    String? tripId,
    String? title,
    String? city,
    String? destinationGovernorate,
    DateTime? tripStart,
    DateTime? tripEnd,
    int? durationDays,
    int? people,
    int? totalBudget,
    int? totalCost,
    TripStatus? status,
    String? shareToken,
    bool? isPublic,
    String? sessionId,
    String? coverImageUrl,
    int? placesCount,
    int? progressPercent,
    GeneratedPlanEntity? plan,
    CollectedPlannerDataEntity? collected,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Trip(
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      city: city ?? this.city,
      destinationGovernorate:
          destinationGovernorate ?? this.destinationGovernorate,
      tripStart: tripStart ?? this.tripStart,
      tripEnd: tripEnd ?? this.tripEnd,
      durationDays: durationDays ?? this.durationDays,
      people: people ?? this.people,
      totalBudget: totalBudget ?? this.totalBudget,
      totalCost: totalCost ?? this.totalCost,
      status: status ?? this.status,
      shareToken: shareToken ?? this.shareToken,
      isPublic: isPublic ?? this.isPublic,
      sessionId: sessionId ?? this.sessionId,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      placesCount: placesCount ?? this.placesCount,
      progressPercent: progressPercent ?? this.progressPercent,
      plan: plan ?? this.plan,
      collected: collected ?? this.collected,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static Trip empty() {
    return Trip(
      tripId: '',
      title: 'Trip to Place',
      city: '',
      destinationGovernorate: 'Governorate',
      tripStart: DateTime.now(),
      tripEnd: DateTime.now(),
      durationDays: 0,
      people: 0,
      totalBudget: 0,
      totalCost: 0,
      status: TripStatus.draft,
      shareToken: '',
      isPublic: false,
      sessionId: '',
      coverImageUrl: null,
      placesCount: 0,
      progressPercent: 0,
      plan: const GeneratedPlanEntity(
        tripId: '',
        status: 'draft',
        people: 1,
        totalCalculatedCost: 0,
        daysCount: 0,
        days: {},
        accommodation: [],
      ),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
