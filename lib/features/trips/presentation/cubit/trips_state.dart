import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

enum TripsStatus { initial, loading, loaded, error }

enum TripFilterTab { all, inProgress, completed, drafts }

class TripsState extends Equatable {
  final List<Trip> trips;
  final TripsStatus tripsStatus;
  final String? errorMessage;
  final String searchQuery;
  final TripFilterTab selectedTab;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final String? generatedTripId;
  final bool isGenerating;
  const TripsState({
    this.trips = const [],
    this.tripsStatus = TripsStatus.initial,
    this.errorMessage,
    this.searchQuery = "",
    this.selectedTab = TripFilterTab.all,
    required this.focusedDay,
    this.selectedDay,
    this.generatedTripId,
    this.isGenerating = false,
  });

  TripsState copyWith({
    List<Trip>? trips,
    TripsStatus? tripsStatus,
    String? errorMessage,
    String? searchQuery,
    TripFilterTab? selectedTab,
    DateTime? focusedDay,
    DateTime? selectedDay,
    String? generatedTripId,
    bool clearGeneratedTripId = false,
    bool? isGenerating,
  }) {
    return TripsState(
      trips: trips ?? this.trips,
      tripsStatus: tripsStatus ?? this.tripsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTab: selectedTab ?? this.selectedTab,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      generatedTripId: clearGeneratedTripId
          ? null
          : generatedTripId ?? this.generatedTripId,
      isGenerating: isGenerating ?? this.isGenerating,
    );
  }

  List<Trip> get drafts =>
      trips.where((t) => t.status == TripStatus.draft).toList();

  Trip? getTripById(String id) =>
      trips.where((t) => t.tripId == id).firstOrNull;

  int getTripIndex(String id) => trips.indexWhere((t) => t.tripId == id);

  List<Trip> get completed =>
      trips.where((t) => t.status == TripStatus.completed).toList();

  List<Trip> get inProgress =>
      trips.where((t) => t.status == TripStatus.inProgress).toList();

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
      case TripFilterTab.inProgress:
        list = inProgress;
        break;
      case TripFilterTab.completed:
        list = completed;
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
              t.destinationGovernorate.toLowerCase().contains(searchQuery),
        )
        .toList();
  }

  @override
  List<Object?> get props => [
    trips,
    tripsStatus,
    errorMessage,
    searchQuery,
    selectedTab,
    focusedDay,
    selectedDay,
    generatedTripId,
    isGenerating,
  ];
}
