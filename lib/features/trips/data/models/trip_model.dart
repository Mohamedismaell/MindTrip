import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'dart:convert';
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

  @HiveField(16)
  final String? itineraryCoverUrl;

  @HiveField(17)
  final String placePreviewsJson;

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
    this.itineraryCoverUrl,
    this.placePreviewsJson = '[]',
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
      itineraryCoverUrl: trip.itineraryCoverUrl,
      placePreviewsJson: jsonEncode(trip.placePreviews),
    );
  }

  Trip toEntity() {
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
      itineraryCoverUrl: itineraryCoverUrl,
      placePreviews: _parsePlacePreviews(),
    );
  }

  List<Map<String, String>> _parsePlacePreviews() {
    try {
      final List<dynamic> decoded = jsonDecode(placePreviewsJson);
      return decoded.map((e) => Map<String, String>.from(e as Map)).toList();
    } catch (_) {
      return [];
    }
  }
}
