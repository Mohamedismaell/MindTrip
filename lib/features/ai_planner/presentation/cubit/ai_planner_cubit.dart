import 'package:mindtrip/core/shared/models/interest_categories.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/generate_plan_use_case.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/presentation/data/ai_planner_mock_data.dart';
import 'package:uuid/uuid.dart';
import 'ai_planner_state.dart';

class AiPlannerCubit extends SafeCubit<AiPlannerState> {
  AiPlannerCubit({required GeneratePlanUseCase generatePlanUseCase})
    : _generatePlanUseCase = generatePlanUseCase,
      super(
        AiPlannerState(
          focusedDay: DateTime.now(),
          visibleMonth: DateTime(DateTime.now().year, DateTime.now().month),
          sessionId: const Uuid().v4(),
        ),
      );

  final GeneratePlanUseCase _generatePlanUseCase;

  void reset() {
    emitSafe(
      AiPlannerState(
        focusedDay: DateTime.now(),
        visibleMonth: DateTime(DateTime.now().year, DateTime.now().month),
        sessionId: const Uuid().v4(),
      ),
    );
  }

  void createNewSession() {
    emit(state.copyWith(sessionId: const Uuid().v4()));
  }

  void loadFromTrip(Trip trip) {
    emitSafe(
      state.copyWith(
        tripId: trip.id,
        selectedDestination: trip.destination,
        destinationQuery: trip.destination,
        tripStart: trip.tripStart,
        tripEnd: trip.tripEnd,
        adults: trip.people,
        children: 0,
        selectedBudget: null,
        customBudget: trip.totalBudget.toString(),
        selectedInterests: trip.interests,
      ),
    );
  }

  Trip toTripSnapshot({required String tripId}) {
    return Trip(
      id: tripId,
      title: 'Trip to ${state.selectedDestination ?? 'Unknown'}',
      status: TripStatus.draft,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      destination: state.selectedDestination ?? '',
      tripStart: state.tripStart,
      tripEnd: state.tripEnd,
      people: state.adults + state.children,
      totalBudget: int.tryParse(state.customBudget) ?? 0,
      totalCost: 0,
      interests: state.selectedInterests,
    );
  }

  void setPage(int page) {
    emitSafe(
      state.copyWith(
        currentPage: page,
        maxReachedPage: page > state.maxReachedPage
            ? page
            : state.maxReachedPage,
      ),
    );
  }

  bool goNext() {
    if (state.currentPage >= 4) {
      return false;
    }

    final next = state.currentPage + 1;

    emitSafe(
      state.copyWith(
        currentPage: next,
        maxReachedPage: next > state.maxReachedPage
            ? next
            : state.maxReachedPage,
      ),
    );

    return true;
  }

  bool goBack() {
    if (state.currentPage == 0) {
      return false;
    }

    emitSafe(state.copyWith(currentPage: state.currentPage - 1));

    return true;
  }

  void updateDestinationQuery(String query) {
    if (state.selectedDestination != null &&
        state.selectedDestination!.toLowerCase() !=
            query.trim().toLowerCase()) {
      emitSafe(state.copyWith(destinationQuery: query));
    } else {
      emitSafe(state.copyWith(destinationQuery: query));
    }
  }

  void selectDestination(String destination) {
    emitSafe(
      state.copyWith(selectedDestination: destination, destinationQuery: ''),
    );
  }

  void selectTripDate(DateTime day) {
    final picked = DateTime(day.year, day.month, day.day);

    if (state.tripStart == null) {
      emitSafe(state.copyWith(tripStart: picked, tripEnd: null));
      return;
    }

    if (state.tripEnd != null) {
      emitSafe(state.copyWith(tripStart: picked, tripEnd: null));
      return;
    }

    if (picked.isBefore(state.tripStart!)) {
      emitSafe(state.copyWith(tripStart: picked, tripEnd: null));
      return;
    }

    emitSafe(state.copyWith(tripEnd: picked));
  }

  // Month navigation

  void nextMonth() {
    final current = state.focusedDay;
    final next = DateTime(current.year, current.month + 1, 1);
    if (next.isAfter(DateTime.utc(2030, 12, 31))) return;
    emitSafe(state.copyWith(focusedDay: next));
  }

  void changeMonth(DateTime focusedDay) {
    final firstDay = DateTime.utc(2020, 1, 1);
    final lastDay = DateTime.utc(2030, 12, 31);

    if (focusedDay.isBefore(firstDay)) {
      emitSafe(state.copyWith(focusedDay: firstDay));
    } else if (focusedDay.isAfter(lastDay)) {
      emitSafe(state.copyWith(focusedDay: lastDay));
    } else {
      emitSafe(state.copyWith(focusedDay: focusedDay));
    }
  }

  void previousMonth() {
    final current = state.focusedDay;
    final prev = DateTime(current.year, current.month - 1, 1);
    if (prev.isBefore(DateTime.utc(2020, 1, 1))) return;
    emitSafe(state.copyWith(focusedDay: prev));
  }

  // Travelers

  void changeAdults(int delta) {
    emitSafe(state.copyWith(adults: (state.adults + delta).clamp(1, 12)));
  }

  void changeChildren(int delta) {
    emitSafe(state.copyWith(children: (state.children + delta).clamp(0, 12)));
  }

  // Budget

  void selectBudget(BudgetTierModel budget) {
    emitSafe(
      state.copyWith(
        selectedBudget: budget,
        customBudget: budget.amount.toString(),
      ),
    );
  }

  void updateCustomBudget(String value) {
    if (value.trim().isNotEmpty) {
      emitSafe(state.copyWith(customBudget: value));
    } else {
      emitSafe(state.copyWith(customBudget: value));
    }
  }

  // Interests
  void toggleInterest(String interest) {
    final currentInterests = List<String>.from(state.selectedInterests);

    if (currentInterests.contains(interest)) {
      currentInterests.remove(interest);
    } else {
      currentInterests.add(interest);
    }

    emitSafe(state.copyWith(selectedInterests: currentInterests));
  }

  // Helpers

  List<String> getFilteredDestinations(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      return AiPlannerMockData.destinations;
    }
    final filteredDestinations = AiPlannerMockData.destinations
        .where((destination) => destination.toLowerCase().contains(q))
        .toList();
    return filteredDestinations;
  }

  Future<void> generatePlan({
    GeneratePlanRequestModel? generatePlanRequestModel,
  }) async {
    emitSafe(state.copyWith(status: AiPlannerStatus.loading));

    final planResult = await _generatePlanUseCase(
      request:
          generatePlanRequestModel ??
          GeneratePlanRequestModel(
            interests: state.selectedInterests
                .map(InterestCategories.stripEmoji)
                .toList(),
            city: state.selectedDestination!,
            days: state.tripEnd!.difference(state.tripStart!).inDays + 1,
            people: state.adults + state.children,
            budget: int.tryParse(state.customBudget) ?? 0,
          ),
    );
    planResult.when(
      success: (plan) async {
        emitSafe(
          state.copyWith(
            status: AiPlannerStatus.success,
            tripId: plan.tripId,
            generatedPlan: plan,
          ),
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            status: AiPlannerStatus.failure,
            errorMessage: 'Failed to generate plan: ${error.message}',
          ),
        );
      },
      cancelled: () {},
    );
  }
}
