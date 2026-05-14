import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';

enum TripsStatus { initial, loading, loaded, error }

class TripsState extends Equatable {
  final List<Trip> trips;
  final TripsStatus status;
  final String? errorMessage;

  const TripsState({
    this.trips = const [],
    this.status = TripsStatus.initial,
    this.errorMessage,
  });

  TripsState copyWith({
    List<Trip>? trips,
    TripsStatus? status,
    String? errorMessage,
  }) {
    return TripsState(
      trips: trips ?? this.trips,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Trip> get drafts =>
      trips.where((t) => t.status == TripStatus.draft).toList();

  List<Trip> get completed =>
      trips.where((t) => t.status == TripStatus.completed).toList();

  List<Trip> get recentlyEdited {
    final list = List<Trip>.from(trips);
    list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return list;
  }

  @override
  List<Object?> get props => [trips, status, errorMessage];
}
