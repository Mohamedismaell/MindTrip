import 'package:mindtrip/core/shared/models/interest_categories.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/generate_plan_use_case.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/trips/data/mapper/create_trip_request_mapper.dart';
import 'package:mindtrip/features/trips/data/models/update_trip_plan_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/create_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/update_trip_plan_use_case.dart';

class AddToTripCubit extends SafeCubit<AddToTripState> {
  final GetAllTripsUseCase _getAllTripsUseCase;
  final GeneratePlanUseCase _generatePlanUseCase;
  final CreateTripUseCase _createTripUseCase;
  final UpdateTripPlanUseCase _updateTripPlanUseCase;

  AddToTripCubit({
    required PlaceEntity place,
    required GetAllTripsUseCase getAllTripsUseCase,
    required GeneratePlanUseCase generatePlanUseCase,
    required CreateTripUseCase createTripUseCase,
    required UpdateTripPlanUseCase updateTripPlanUseCase,
  }) : _getAllTripsUseCase = getAllTripsUseCase,
       _generatePlanUseCase = generatePlanUseCase,
       _createTripUseCase = createTripUseCase,
       _updateTripPlanUseCase = updateTripPlanUseCase,
       super(AddToTripState(place: place));

  void _emitStatus(AddToTripStatus status) {
    emitSafe(state.copyWith(status: status, errorMessage: ''));
  }

  void _emitFailure(AddToTripStatus status, String message) {
    emitSafe(state.copyWith(status: status, errorMessage: message));
  }

  Future<void> loadTrips() async {
    _emitStatus(AddToTripStatus.loadingTrips);

    final result = await _getAllTripsUseCase();

    result.when(
      success: (trips) {
        final placeCities = {
          state.place.location.cityEn.trim().toLowerCase(),
          // state.place.location.city.trim().toLowerCase(),
        }..removeWhere((e) => e.isEmpty);

        final filteredTrips = trips.where((t) {
          if (t.status == TripStatus.completed) return false;

          final tripCity = t.city.trim().toLowerCase();
          return placeCities.contains(tripCity);
        }).toList();

        emitSafe(
          state.copyWith(
            status: AddToTripStatus.initial,
            errorMessage: '',
            trips: filteredTrips,
          ),
        );
      },
      failure: (error) {
        _emitFailure(AddToTripStatus.loadingTripsFailure, error.message);
      },
      cancelled: () {},
    );
  }

  void selectTrip(Trip? trip) {
    emitSafe(
      state.copyWith(
        selectedTrip: trip,
        clearSelectedDay: true,
        clearSelectedPeriod: true,
      ),
    );
  }

  void selectDay(String? day) {
    emitSafe(state.copyWith(selectedDay: day, clearSelectedPeriod: true));
  }

  void selectDayAndPeriod(String? day, PlaceDayPeriod? period) {
    emitSafe(state.copyWith(selectedDay: day, selectedPeriod: period));
  }

  int? _extractDayNumber(String? rawDay) {
    if (rawDay == null || rawDay.trim().isEmpty) return null;
    final match = RegExp(r'\d+').firstMatch(rawDay);
    return match != null ? int.tryParse(match.group(0)!) : null;
  }

  PlanPlaceModel _mapPlaceToPlanPlace({
    required PlaceEntity place,
    required int dayNumber,
  }) {
    return PlanPlaceModel(
      placeId: place.id,
      name: place.name,
      city: place.location.city,
      cityEn: place.location.cityEn,
      interests: const [],
      category: place.category.name,
      rating: place.rating ?? 0,
      reviewsCount: place.reviewCount ?? 0,
      address: place.location.address,
      description: place.description ?? '',
      photoUrl: '',
      imageUrls: const [],
      mapsUrl: '',
      openingHours: '',
      isOpened: false,
      lat: 0,
      lng: 0,
      day: dayNumber,
      type: 'Activity',
      price: 0,
      cost: 0,
      isHiddenGem: false,
    );
  }

  DayPlanModel _addPlaceToPeriod({
    required DayPlanModel dayPlan,
    required PlaceDayPeriod period,
    required PlanPlaceModel place,
  }) {
    switch (period) {
      case PlaceDayPeriod.morning:
        return dayPlan.copyWith(morning: [...dayPlan.morning, place]);
      case PlaceDayPeriod.afternoon:
        return dayPlan.copyWith(afternoon: [...dayPlan.afternoon, place]);
      case PlaceDayPeriod.evening:
        return dayPlan.copyWith(evening: [...dayPlan.evening, place]);
    }
  }

  Future<void> addToExistingTrip() async {
    final trip = state.selectedTrip;
    final selectedPeriod = state.selectedPeriod;
    final dayNumber = _extractDayNumber(state.selectedDay);

    if (trip == null || selectedPeriod == null || dayNumber == null) return;

    _emitStatus(AddToTripStatus.updatingTrip);

    try {
      final currentGeneratedPlan = trip.plan.toModel();
      final currentPlan = currentGeneratedPlan.plan;

      if (currentPlan == null) {
        _emitFailure(AddToTripStatus.saveFailure, 'Trip plan is missing.');
        return;
      }

      final newPlace = _mapPlaceToPlanPlace(
        place: state.place,
        dayNumber: dayNumber,
      );

      final alreadyExistsInTrip = currentPlan.days.values.any(
        (dayPlan) =>
            dayPlan.allPlaces.any((place) => place.placeId == newPlace.placeId),
      );

      if (alreadyExistsInTrip) {
        _emitFailure(
          AddToTripStatus.saveFailure,
          'This place is already added to this trip.',
        );
        return;
      }

      final updatedDays = Map<int, DayPlanModel>.from(currentPlan.days);
      final existingDayPlan = updatedDays[dayNumber] ?? const DayPlanModel();

      updatedDays[dayNumber] = _addPlaceToPeriod(
        dayPlan: existingDayPlan,
        period: selectedPeriod,
        place: newPlace,
      );

      final updatedPlan = currentPlan.copyWith(days: updatedDays);

      final updatedGeneratedPlan = currentGeneratedPlan.copyWith(
        totalCalculatedCost: currentGeneratedPlan.totalCalculatedCost,
        daysCount: currentGeneratedPlan.daysCount > 0
            ? currentGeneratedPlan.daysCount
            : (trip.durationDays > 0 ? trip.durationDays : 1),
        plan: updatedPlan,
      );

      final updateRequest = UpdateTripPlanRequestModel(
        title: trip.title,
        destinationGovernorate: trip.destinationGovernorate,
        city: trip.city,
        startDate: trip.tripStart.toIso8601String(),
        endDate: trip.tripEnd.toIso8601String(),
        people: trip.people,
        totalBudgetEgp: trip.totalBudget,
        totalCost: updatedGeneratedPlan.totalCalculatedCost,
        plan: updatedGeneratedPlan,
        collected: trip.collected != null
            ? CollectedDataModel.fromEntity(trip.collected!)
            : null,
        sessionId: trip.sessionId,
        isPublic: trip.isPublic,
      );

      final saveResult = await _updateTripPlanUseCase(
        trip.tripId,
        updateRequest,
      );

      saveResult.when(
        success: (_) {
          emitSafe(
            state.copyWith(status: AddToTripStatus.success, errorMessage: ''),
          );
        },
        failure: (error) {
          _emitFailure(AddToTripStatus.saveFailure, error.message);
        },
        cancelled: () {},
      );
    } catch (_) {
      _emitFailure(
        AddToTripStatus.saveFailure,
        'Failed to update the trip plan.',
      );
    }
  }

  Future<void> createNewTripAndAdd({
    required List<String> userInterests,
  }) async {
    if (state.startDate == null || state.endDate == null) return;

    if (!state.canCreateTrip) {
      _emitFailure(
        AddToTripStatus.generateFailure,
        state.budgetValidationMessage ??
            'Please complete the required fields first.',
      );
      return;
    }

    final budget = state.resolvedBudget;
    if (budget <= 0) {
      _emitFailure(
        AddToTripStatus.generateFailure,
        'Please select a valid budget before creating the trip.',
      );
      return;
    }

    _emitStatus(AddToTripStatus.generatingNewTripPlan);

    final days = state.endDate!.difference(state.startDate!).inDays + 1;

    final request = GeneratePlanRequestModel(
      city: state.place.location.cityEn,
      days: days,
      people: state.adultCount,
      budget: budget,
      interests: userInterests
          .map((e) => InterestCategories.stripEmoji(e))
          .toList(),
      mustInclude: [
        GeneratePlanMustIncludeItem(
          name: state.place.name,
          placeId: state.place.id,
        ),
      ],
    );

    final result = await _generatePlanUseCase(request: request);

    await result.when(
      success: (plan) async {
        _emitStatus(AddToTripStatus.creatingTrip);

        final collected = CollectedPlannerDataEntity(
          destination: state.place.location.cityEn,
          days: days,
          people: state.adultCount,
          budget: budget,
          mustInclude: [state.place.name],
        );

        final createRequest = plan.toCreateTripRequest(
          collected: collected,
          sessionId: 'add_to_trip_${state.place.id}',
          startDate: state.startDate,
          endDate: state.endDate,
        );

        final saveResult = await _createTripUseCase(createRequest);

        saveResult.when(
          success: (trip) {
            emitSafe(
              state.copyWith(
                status: AddToTripStatus.success,
                errorMessage: '',
                createdTrip: trip,
              ),
            );
          },
          failure: (error) {
            _emitFailure(AddToTripStatus.saveFailure, error.message);
          },
          cancelled: () {},
        );
      },
      failure: (error) {
        _emitFailure(AddToTripStatus.generateFailure, error.message);
      },
      cancelled: () {},
    );
  }

  void updateStartDate(DateTime? date) {
    emitSafe(state.copyWith(startDate: date));
  }

  void updateEndDate(DateTime? date) {
    emitSafe(state.copyWith(endDate: date));
  }

  void updateAdults(int count) {
    emitSafe(state.copyWith(adultCount: count));
  }

  void selectBudget(BudgetTierModel? value) {
    emitSafe(state.copyWith(selectedBudget: value, customBudget: ''));
  }

  void updateCustomBudget(String value) {
    emitSafe(state.copyWith(customBudget: value, clearSelectedBudget: true));
  }

  void setPage(int page) {
    emitSafe(state.copyWith(currentPage: page));
  }
}
