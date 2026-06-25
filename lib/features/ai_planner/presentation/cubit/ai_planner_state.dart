import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';

part 'ai_planner_state.freezed.dart';

enum AiPlannerStatus { initial, loading, success, failure }

@freezed
abstract class AiPlannerState with _$AiPlannerState {
  const factory AiPlannerState({
    String? tripId,
    GeneratedPlanEntity? generatedPlan,
    @Default(AiPlannerStatus.initial) AiPlannerStatus status,
    @Default('') String errorMessage,
    @Default(0) int currentPage,

    @Default(0) int maxReachedPage,

    String? selectedDestination,

    @Default('') String destinationQuery,

    DateTime? tripStart,

    DateTime? tripEnd,

    @Default(0) int adults,

    @Default(0) int children,

    BudgetTierModel? selectedBudget,

    @Default('') String customBudget,

    DateTime? visibleMonth,

    @Default(<String>[]) List<String> selectedInterests,

    required DateTime focusedDay,
  }) = _AiPlannerState;

  const AiPlannerState._();

  DateTime get resolvedVisibleMonth =>
      visibleMonth ?? DateTime(DateTime.now().year, DateTime.now().month);

  bool get canContinue {
    switch (currentPage) {
      case 0:
        return selectedDestination != null;

      case 1:
        return tripStart != null && tripEnd != null;

      case 2:
        return adults + children > 0;

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

    return '${monthNames[resolvedVisibleMonth.month - 1]} ${resolvedVisibleMonth.year}';
  }
}
