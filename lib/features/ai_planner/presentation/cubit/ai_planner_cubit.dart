import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/presentation/data/ai_planner_mock_data.dart';

import 'ai_planner_state.dart';

class AiPlannerCubit extends Cubit<AiPlannerState> {
  AiPlannerCubit() : super(AiPlannerState());

  void setPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void nextPage() {
    if (state.currentPage < 4) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
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
    final current = state.visibleMonth;
    emit(
      state.copyWith(visibleMonth: DateTime(current.year, current.month + 1)),
    );
  }

  void previousMonth() {
    final current = state.visibleMonth;
    emit(
      state.copyWith(visibleMonth: DateTime(current.year, current.month - 1)),
    );
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
