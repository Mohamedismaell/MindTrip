import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';

class AiPlannerState extends Equatable {
  final int currentPage;
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

  AiPlannerState({
    this.currentPage = 0,
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
  }) : visibleMonth = visibleMonth ?? DateTime(DateTime.now().year, DateTime.now().month);

  AiPlannerState copyWith({
    int? currentPage,
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
  }) {
    return AiPlannerState(
      currentPage: currentPage ?? this.currentPage,
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
        return selectedBudget != null;
      default:
        return false;
    }
  }

  String get monthLabel {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${monthNames[visibleMonth.month - 1]} ${visibleMonth.year}';
  }

  @override
  List<Object?> get props => [
    currentPage,
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
  ];
}
