import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planning_session.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/delete_planning_session_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/get_planning_session_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/save_planning_session_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/data/ai_planner_mock_data.dart';

import 'ai_planner_state.dart';

class AiPlannerCubit extends Cubit<AiPlannerState> {
  final GetPlanningSessionUseCase _getPlanningSessionUseCase;
  final SavePlanningSessionUseCase _savePlanningSessionUseCase;
  final DeletePlanningSessionUseCase _deletePlanningSessionUseCase;

  AiPlannerCubit(
    this._getPlanningSessionUseCase,
    this._savePlanningSessionUseCase,
    this._deletePlanningSessionUseCase,
  ) : super(AiPlannerState(focusedDay: DateTime.now()));

  void reset() {
    emit(AiPlannerState(focusedDay: DateTime.now()));
  }

  Future<PlanningSession?> loadSession(String tripId) async {
    final result = await _getPlanningSessionUseCase(tripId);
    return result.when(
      success: (session) {
        if (session != null) {
          emit(
            state.copyWith(
              tripId: session.id,
              currentPage: session.currentPage,
              maxReachedPage: session.currentPage,
            ),
          );
        }
        return session;
      },
      failure: (_) => null,
    );
  }

  Future<void> saveCurrentSession({
    List<ChatMessage> chatMessages = const [],
    String? tripId,
  }) async {
    final id = tripId ?? state.tripId;
    if (id == null) return;

    final session = PlanningSession(
      id: id,
      currentPage: state.currentPage,
      chatMessages: chatMessages,
      updatedAt: DateTime.now(),
    );
    await _savePlanningSessionUseCase(session);
  }

  Future<void> clearSession({String? tripId}) async {
    final id = tripId ?? state.tripId;
    if (id == null) return;
    await _deletePlanningSessionUseCase(id);
  }

  void loadFromTrip(Trip trip) {
    BudgetTierModel? matchingBudget;
    if (trip.budgetTier != null) {
      try {
        matchingBudget = AiPlannerMockData.budgetTiers.firstWhere(
          (b) => b.title == trip.budgetTier,
        );
      } catch (_) {}
    }

    emit(
      state.copyWith(
        tripId: trip.id,
        selectedDestination: trip.destination,
        destinationQuery: trip.destination,
        tripStart: trip.tripStart,
        tripEnd: trip.tripEnd,
        adults: trip.adults,
        children: trip.children,
        pets: trip.pets,
        selectedBudget: trip.budgetTier != null ? matchingBudget : null,
        customBudget: trip.customBudget,
        selectedInterests: trip.interests,
      ),
    );
  }

  void markReadyToGenerate() {
    emit(state.copyWith(maxReachedPage: 5));
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
      adults: state.adults,
      children: state.children,
      pets: state.pets,
      budgetTier: state.selectedBudget?.title,
      customBudget: state.customBudget,
      interests: state.selectedInterests,
    );
  }

  void setPage(int page) {
    emit(
      state.copyWith(
        currentPage: page,
        maxReachedPage: page > state.maxReachedPage
            ? page
            : state.maxReachedPage,
      ),
    );
  }

  void nextPage() {
    if (state.currentPage < 4) {
      final next = state.currentPage + 1;
      emit(
        state.copyWith(
          currentPage: next,
          maxReachedPage: next > state.maxReachedPage
              ? next
              : state.maxReachedPage,
        ),
      );
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  void updateDestinationQuery(String query) {
    if (state.selectedDestination != null &&
        state.selectedDestination!.toLowerCase() !=
            query.trim().toLowerCase()) {
      emit(state.copyWith(destinationQuery: query, clearDestination: true));
    } else {
      emit(state.copyWith(destinationQuery: query));
    }
  }

  void selectDestination(String destination) {
    emit(
      state.copyWith(
        selectedDestination: destination,
        destinationQuery: destination,
      ),
    );
  }

  void selectTripDate(DateTime day) {
    final picked = DateTime(day.year, day.month, day.day);
    if (state.tripStart == null ||
        (state.tripStart != null && state.tripEnd != null)) {
      emit(state.copyWith(tripStart: picked, clearTripEnd: true));
      return;
    }

    if (picked.isBefore(state.tripStart!)) {
      emit(state.copyWith(tripStart: picked));
      return;
    }

    emit(state.copyWith(tripEnd: picked));
  }

  // Month navigation

  void nextMonth() {
    final current = state.focusedDay;
    final next = DateTime(current.year, current.month + 1, 1);
    if (next.isAfter(DateTime.utc(2030, 12, 31))) return;
    emit(state.copyWith(focusedDay: next));
  }

  void changeMonth(DateTime focusedDay) {
    final firstDay = DateTime.utc(2020, 1, 1);
    final lastDay = DateTime.utc(2030, 12, 31);

    if (focusedDay.isBefore(firstDay)) {
      emit(state.copyWith(focusedDay: firstDay));
    } else if (focusedDay.isAfter(lastDay)) {
      emit(state.copyWith(focusedDay: lastDay));
    } else {
      emit(state.copyWith(focusedDay: focusedDay));
    }
  }

  void previousMonth() {
    final current = state.focusedDay;
    final prev = DateTime(current.year, current.month - 1, 1);
    if (prev.isBefore(DateTime.utc(2020, 1, 1))) return;
    emit(state.copyWith(focusedDay: prev));
  }

  // Travelers

  void changeAdults(int delta) {
    emit(state.copyWith(adults: (state.adults + delta).clamp(1, 12)));
  }

  void changeChildren(int delta) {
    emit(state.copyWith(children: (state.children + delta).clamp(0, 12)));
  }

  void changePets(int delta) {
    emit(state.copyWith(pets: (state.pets + delta).clamp(0, 6)));
  }

  // Budget

  void selectBudget(BudgetTierModel budget) {
    emit(state.copyWith(selectedBudget: budget, customBudget: ''));
  }

  void updateCustomBudget(String value) {
    if (value.trim().isNotEmpty) {
      emit(state.copyWith(customBudget: value, clearSelectedBudget: true));
    } else {
      emit(state.copyWith(customBudget: value));
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

    emit(state.copyWith(selectedInterests: currentInterests));
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
}
