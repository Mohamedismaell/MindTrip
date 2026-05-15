import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';

enum TripsStatus { initial, loading, loaded, error }

enum TripFilterTab { all, completed, recentlyEdited, drafts }

class TripsState extends Equatable {
  final List<Trip> trips;
  final TripsStatus status;
  final String? errorMessage;
  final String searchQuery;
  final TripFilterTab selectedTab;
  const TripsState({
    this.trips = const [],
    this.status = TripsStatus.initial,
    this.errorMessage,
    this.searchQuery = "",
    this.selectedTab = TripFilterTab.all,
  });

  TripsState copyWith({
    List<Trip>? trips,
    TripsStatus? status,
    String? errorMessage,
    String? searchQuery,
    TripFilterTab? selectedTab,
  }) {
    return TripsState(
      trips: trips ?? this.trips,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTab: selectedTab ?? this.selectedTab,
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

  List<Trip> get filterTrips {
    List<Trip> list = [];
    switch (selectedTab) {
      case TripFilterTab.all:
        list = trips;
        break;
      case TripFilterTab.completed:
        list = completed;
        break;
      case TripFilterTab.recentlyEdited:
        list = recentlyEdited;
        break;
      case TripFilterTab.drafts:
        list = drafts;
        break;
    }

    if (searchQuery.isEmpty) return list;
    return list
        .where(
          (t) =>
              t.title.toLowerCase().contains(searchQuery) ||
              t.destination.toLowerCase().contains(searchQuery),
        )
        .toList();
  }

  @override
  List<Object?> get props => [
    trips,
    status,
    errorMessage,
    searchQuery,
    selectedTab,
  ];
}
