import 'package:mindtrip/core/shared/models/interest_categories.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/generate_plan_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/data/ai_planner_mock_data.dart';
import 'package:mindtrip/features/trips/data/mapper/create_trip_request_mapper.dart';
import 'package:mindtrip/features/trips/domain/use_cases/create_trip_use_case.dart';
import 'package:uuid/uuid.dart';

import 'ai_planner_state.dart';

class AiPlannerCubit extends SafeCubit<AiPlannerState> {
  AiPlannerCubit({
    required GeneratePlanUseCase generatePlanUseCase,
    required CreateTripUseCase createTripUseCase,
  }) : _generatePlanUseCase = generatePlanUseCase,
       _createTripUseCase = createTripUseCase,
       super(
         AiPlannerState(
           focusedDay: DateTime.now(),
           visibleMonth: DateTime(DateTime.now().year, DateTime.now().month),
           sessionId: const Uuid().v4(),
         ),
       );

  final GeneratePlanUseCase _generatePlanUseCase;
  final CreateTripUseCase _createTripUseCase;

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
    emitSafe(
      state.copyWith(
        sessionId: const Uuid().v4(),
        generatedPlan: null,
        collectedData: const CollectedPlannerDataEntity(),
        savedTripId: null,
        status: AiPlannerStatus.initial,
        errorMessage: '',
      ),
    );
  }

  // void loadFromTrip(Trip trip) {
  //   emitSafe(
  //     state.copyWith(
  //       tripId: trip.tripId,
  //       selectedDestination: trip.destinationGovernorate,
  //       destinationQuery: trip.destinationGovernorate,
  //       tripStart: trip.tripStart,
  //       tripEnd: trip.tripEnd,
  //       adults: trip.people,
  //       children: 0,
  //       selectedBudget: null,
  //       customBudget: trip.totalBudget.toString(),
  //       sessionId: trip.sessionId ,
  //     ),
  //   );
  // }

  // Trip toTripSnapshot({required String tripId}) {
  //   return Trip(
  //     id: tripId,
  //     title: 'Trip to ${state.selectedDestination ?? 'Unknown'}',
  //     status: TripStatus.draft,
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //     destination: state.selectedDestination ?? '',
  //     tripStart: state.tripStart,
  //     tripEnd: state.tripEnd,
  //     people: state.adults + state.children,
  //     totalBudget: int.tryParse(state.customBudget) ?? 0,
  //     totalCost: 0,
  //     interests: state.selectedInterests,
  //   );
  // }

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
    emitSafe(state.copyWith(destinationQuery: query));
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
    emitSafe(state.copyWith(selectedBudget: budget, customBudget: ''));
  }

  void updateCustomBudget(String value) {
    emitSafe(
      state.copyWith(
        customBudget: value,
        selectedBudget: value.trim().isEmpty ? state.selectedBudget : null,
      ),
    );
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
    return AiPlannerMockData.destinations
        .where((destination) => destination.toLowerCase().contains(q))
        .toList();
  }

  Future<void> generatePlan({
    GeneratePlanRequestModel? generatePlanRequestModel,
    DateTime? tripStart,
  }) async {
    final request = generatePlanRequestModel ?? _buildGeneratePlanRequest();
    final collectedData = _buildCollectedData(request);
    final start = tripStart ?? state.tripStart;
    final end = start?.add(Duration(days: request.days - 1));
    emitSafe(
      state.copyWith(
        status: AiPlannerStatus.generatingPlan,
        errorMessage: '',
        generatedPlan: null,
        savedTripId: null,
        collectedData: collectedData,
        tripStart: start,
        tripEnd: end,
      ),
    );

    final planResult = await _generatePlanUseCase(request: request);
    await planResult.when(
      success: (plan) async {
        emitSafe(
          state.copyWith(
            status: AiPlannerStatus.generated,
            generatedPlan: plan,
            collectedData: collectedData,
          ),
        );
        await saveGeneratedTrip();
      },
      failure: (error) async {
        emitSafe(
          state.copyWith(
            status: AiPlannerStatus.generateFailure,
            errorMessage: error.message,
          ),
        );
      },
      cancelled: () async {},
    );
  }

  Future<void> saveGeneratedTrip() async {
    final generatedPlan = state.generatedPlan;
    if (generatedPlan == null) return;

    emitSafe(
      state.copyWith(status: AiPlannerStatus.savingTrip, errorMessage: ''),
    );
    // debugPrint('================ GENERATED PLAN ================');
    // debugPrint('daysCount = ${generatedPlan.daysCount}');
    // debugPrint('days keys = ${generatedPlan.days.keys}');
    // debugPrint('days length = ${generatedPlan.days.length}');
    // debugPrint('accommodation = ${generatedPlan.accommodation.length}');
    final request = generatedPlan.toCreateTripRequest(
      collected: state.collectedData,
      sessionId: state.sessionId,
      startDate: state.tripStart,
      endDate: state.tripEnd,
    );
    // debugPrint('================ REQUEST MODEL ================');
    // debugPrint('request.plan.plan.days = ${request.plan.plan?.days.keys}');
    // debugPrint(
    //   'request.plan.plan.days length = ${request.plan.plan?.days.length}',
    // );

    final saveResult = await _createTripUseCase(request);
    saveResult.when(
      success: (trip) {
        emitSafe(
          state.copyWith(
            status: AiPlannerStatus.success,
            savedTripId: trip.tripId,
          ),
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            status: AiPlannerStatus.saveFailure,
            errorMessage: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  GeneratePlanRequestModel _buildGeneratePlanRequest() {
    return GeneratePlanRequestModel(
      interests: state.selectedInterests
          .map(InterestCategories.stripEmoji)
          .toList(),
      city: state.selectedDestination ?? '',
      days: state.tripStart != null && state.tripEnd != null
          ? state.tripEnd!.difference(state.tripStart!).inDays + 1
          : 0,
      people: state.adults + state.children,
      budget: int.tryParse(state.customBudget) ?? 0,
    );
  }

  CollectedPlannerDataEntity _buildCollectedData(
    GeneratePlanRequestModel request,
  ) {
    final mustInclude = request.mustInclude?.trim();
    return CollectedPlannerDataEntity(
      destination: request.city,
      days: request.days,
      budget: request.budget,
      interests: request.interests,
      people: request.people,
      mustInclude: mustInclude == null || mustInclude.isEmpty
          ? const []
          : [mustInclude],
    );
  }
}
