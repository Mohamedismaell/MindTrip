import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

enum AddToTripStatus {
  initial,
  loadingTrips,
  loadingTripsFailure,
  updatingTrip,
  generatingNewTripPlan,
  creatingTrip,
  success,
  generateFailure,
  saveFailure,
}

class AddToTripState extends Equatable {
  final AddToTripStatus status;
  final String errorMessage;
  final PlaceEntity place;
  final List<Trip> trips;
  final Trip? selectedTrip;
  final String? selectedDay;
  final PlaceDayPeriod? selectedPeriod;
  final DateTime? startDate;
  final DateTime? endDate;
  final int adultCount;
  final BudgetTierModel? selectedBudget;
  final String customBudget;
  final int currentPage;
  final Trip? createdTrip;

  const AddToTripState({
    required this.place,
    this.status = AddToTripStatus.initial,
    this.errorMessage = '',
    this.trips = const [],
    this.selectedTrip,
    this.selectedDay,
    this.selectedPeriod,
    this.startDate,
    this.endDate,
    this.adultCount = 1,
    this.selectedBudget,
    this.customBudget = '',
    this.currentPage = 0,
    this.createdTrip,
  });

  int get tripDurationDays {
    if (startDate == null || endDate == null) return 0;
    return endDate!.difference(startDate!).inDays + 1;
  }

  int get minimumBudget {
    if (tripDurationDays <= 0) return 0;
    return tripDurationDays * 1800;
  }

  int get resolvedBudget {
    final custom = int.tryParse(customBudget.trim());
    if (custom != null && custom > 0) return custom;
    return selectedBudget?.amount ?? 0;
  }

  bool get isBudgetValid {
    final hasBudget = selectedBudget != null || customBudget.trim().isNotEmpty;
    if (!hasBudget) return false;
    if (resolvedBudget <= 0) return false;
    if (startDate == null || endDate == null) return true;
    return resolvedBudget >= minimumBudget;
  }

  String? get budgetValidationMessage {
    final hasBudget = selectedBudget != null || customBudget.trim().isNotEmpty;
    if (!hasBudget) return null;

    if (resolvedBudget <= 0) {
      return 'Please select a valid budget';
    }

    if (startDate != null &&
        endDate != null &&
        resolvedBudget < minimumBudget) {
      return 'Minimum budget is EGP $minimumBudget for $tripDurationDays day(s)';
    }

    return null;
  }

  bool get canCreateTrip {
    return startDate != null &&
        endDate != null &&
        adultCount > 0 &&
        isBudgetValid;
  }

  bool get canAddToExistingTrip {
    return selectedTrip != null &&
        selectedDay != null &&
        selectedDay!.trim().isNotEmpty &&
        selectedPeriod != null;
  }

  AddToTripState copyWith({
    AddToTripStatus? status,
    String? errorMessage,
    PlaceEntity? place,
    List<Trip>? trips,
    Trip? selectedTrip,
    bool clearSelectedTrip = false,
    String? selectedDay,
    bool clearSelectedDay = false,
    PlaceDayPeriod? selectedPeriod,
    bool clearSelectedPeriod = false,
    DateTime? startDate,
    bool clearStartDate = false,
    DateTime? endDate,
    bool clearEndDate = false,
    int? adultCount,
    BudgetTierModel? selectedBudget,
    bool clearSelectedBudget = false,
    String? customBudget,
    int? currentPage,
    Trip? createdTrip,
    bool clearCreatedTrip = false,
  }) {
    return AddToTripState(
      place: place ?? this.place,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      trips: trips ?? this.trips,
      selectedTrip: clearSelectedTrip
          ? null
          : (selectedTrip ?? this.selectedTrip),
      selectedDay: clearSelectedDay ? null : (selectedDay ?? this.selectedDay),
      selectedPeriod: clearSelectedPeriod
          ? null
          : (selectedPeriod ?? this.selectedPeriod),
      startDate: clearStartDate ? null : (startDate ?? this.startDate),
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
      adultCount: adultCount ?? this.adultCount,
      selectedBudget: clearSelectedBudget
          ? null
          : (selectedBudget ?? this.selectedBudget),
      customBudget: customBudget ?? this.customBudget,
      currentPage: currentPage ?? this.currentPage,
      createdTrip: clearCreatedTrip ? null : (createdTrip ?? this.createdTrip),
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    place,
    trips,
    selectedTrip,
    selectedDay,
    selectedPeriod,
    startDate,
    endDate,
    adultCount,
    selectedBudget,
    customBudget,
    currentPage,
    createdTrip,
  ];
}
