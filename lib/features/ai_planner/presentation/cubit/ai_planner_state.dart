import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';

class AiPlannerState extends Equatable {
  final String? tripId;
  final int currentPage;
  final int maxReachedPage;
  final String? selectedDestination;
  final String destinationQuery;
  final DateTime? tripStart;
  final DateTime? tripEnd;
  final int adults;
  final int children;
  final int pets;
  final BudgetTierModel? selectedBudget;
  final String customBudget;
  final DateTime visibleMonth;
  final List<String> selectedInterests;
  AiPlannerState({
    this.tripId,
    this.currentPage = 0,
    this.maxReachedPage = 0,
    this.selectedDestination,
    this.destinationQuery = '',
    this.tripStart,
    this.tripEnd,
    this.adults = 1,
    this.children = 0,
    this.pets = 0,
    this.selectedBudget,
    this.customBudget = '',
    DateTime? visibleMonth,
    this.selectedInterests = const [],
  }) : visibleMonth =
           visibleMonth ?? DateTime(DateTime.now().year, DateTime.now().month);

  AiPlannerState copyWith({
    String? tripId,
    int? currentPage,
    int? maxReachedPage,
    String? selectedDestination,
    bool clearDestination = false,
    String? destinationQuery,
    DateTime? tripStart,
    bool clearTripStart = false,
    DateTime? tripEnd,
    bool clearTripEnd = false,
    int? adults,
    int? children,
    int? pets,
    BudgetTierModel? selectedBudget,
    bool clearSelectedBudget = false,
    String? customBudget,
    DateTime? visibleMonth,
    List<String>? selectedInterests,
  }) {
    return AiPlannerState(
      tripId: tripId ?? this.tripId,
      currentPage: currentPage ?? this.currentPage,
      maxReachedPage: maxReachedPage ?? this.maxReachedPage,
      selectedDestination: clearDestination
          ? null
          : selectedDestination ?? this.selectedDestination,
      destinationQuery: destinationQuery ?? this.destinationQuery,
      tripStart: clearTripStart ? null : tripStart ?? this.tripStart,
      tripEnd: clearTripEnd ? null : tripEnd ?? this.tripEnd,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      pets: pets ?? this.pets,
      selectedBudget: clearSelectedBudget
          ? null
          : selectedBudget ?? this.selectedBudget,
      customBudget: customBudget ?? this.customBudget,
      visibleMonth: visibleMonth ?? this.visibleMonth,
      selectedInterests: selectedInterests ?? this.selectedInterests,
    );
  }

  bool get canContinue {
    switch (currentPage) {
      case 0:
        return selectedDestination != null;
      case 1:
        return tripStart != null && tripEnd != null;
      case 2:
        return adults + children + pets > 0;
      case 3:
        return selectedBudget != null || customBudget.isNotEmpty;
      case 4:
        return selectedInterests.isNotEmpty;
      default:
        return false;
    }
  }

  String get monthLabel {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${monthNames[visibleMonth.month - 1]} ${visibleMonth.year}';
  }

  @override
  List<Object?> get props => [
    tripId,
    currentPage,
    maxReachedPage,
    selectedDestination,
    destinationQuery,
    tripStart,
    tripEnd,
    adults,
    children,
    pets,
    selectedBudget,
    customBudget,
    visibleMonth,
    selectedInterests,
  ];
}
