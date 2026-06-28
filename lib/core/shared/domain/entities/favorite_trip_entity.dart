import 'package:equatable/equatable.dart';

class FavoriteTripEntity extends Equatable {
  const FavoriteTripEntity({
    required this.favoriteTripId,
    required this.tripId,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.status,
    required this.createdAt,
  });

  final String favoriteTripId;
  final String tripId;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final String status;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
    favoriteTripId,
    tripId,
    destination,
    startDate,
    endDate,
    durationDays,
    status,
    createdAt,
  ];
}
