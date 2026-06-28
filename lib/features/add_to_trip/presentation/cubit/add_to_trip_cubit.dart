import 'package:mindtrip/core/shared/models/interest_categories.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/ai_planner/data/models/edit_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/edit_plan_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/generate_plan_use_case.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_to_models_mapper.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
import 'package:mindtrip/features/trips/data/mapper/create_trip_request_mapper.dart';
import 'package:mindtrip/features/trips/domain/use_cases/create_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/update_trip_plan_use_case.dart';
import 'package:mindtrip/features/trips/data/models/update_trip_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';

class AddToTripCubit extends SafeCubit<AddToTripState> {
  final GetAllTripsUseCase _getAllTripsUseCase;
  final EditPlanUseCase _editPlanUseCase;
  final GeneratePlanUseCase _generatePlanUseCase;
  final CreateTripUseCase _createTripUseCase;
  final UpdateTripPlanUseCase _updateTripPlanUseCase;

  AddToTripCubit({
    required PlaceEntity place,
    required GetAllTripsUseCase getAllTripsUseCase,
    required EditPlanUseCase editPlanUseCase,
    required GeneratePlanUseCase generatePlanUseCase,
    required CreateTripUseCase createTripUseCase,
    required UpdateTripPlanUseCase updateTripPlanUseCase,
  }) : _getAllTripsUseCase = getAllTripsUseCase,
       _editPlanUseCase = editPlanUseCase,
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
        emitSafe(
          state.copyWith(
            status: AddToTripStatus.initial,
            errorMessage: '',
            trips: trips
                .where((t) => t.status != TripStatus.completed)
                .toList(),
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
    emitSafe(state.copyWith(selectedTrip: trip));
  }

  Future<void> addToExistingTrip() async {
    final trip = state.selectedTrip;
    if (trip == null) return;

    _emitStatus(AddToTripStatus.editingExistingTripPlan);

    final request = EditPlanRequestModel(
      targetChange: 'Add ${state.place.name} to the itinerary',
      destination: trip.city.isNotEmpty
          ? trip.city
          : trip.destinationGovernorate,
      city: trip.city.isNotEmpty ? trip.city : trip.destinationGovernorate,
      days: trip.plan.daysCount > 0
          ? trip.plan.daysCount
          : (trip.durationDays > 0 ? trip.durationDays : 1),
      budget: trip.plan.totalCalculatedCost > 0
          ? trip.plan.totalCalculatedCost
          : (trip.totalBudget > 0 ? trip.totalBudget : 1000),
      people: trip.people > 0 ? trip.people : 1,
      interests: trip.collected?.interests ?? [],
      existingPlan: trip.plan.toModels(),
      mode: 'add',
      item: ItemToEdit(placeId: state.place.id, name: state.place.name),
      tripId: trip.tripId,
    );

    final result = await _editPlanUseCase(request: request);

    await result.when(
      success: (response) async {
        if (response.plan == null) {
          _emitFailure(
            AddToTripStatus.generateFailure,
            response.message ?? 'Failed to add place.',
          );
          return;
        }

        _emitStatus(AddToTripStatus.updatingTrip);

        final plan = response.plan!;
        final updateRequest = UpdateTripPlanRequestModel(
          title: trip.title,
          destinationGovernorate: trip.destinationGovernorate,
          city: trip.city,
          startDate: trip.tripStart.toIso8601String(),
          endDate: trip.tripEnd.toIso8601String(),
          people: trip.people,
          totalBudgetEgp: trip.totalBudget,
          totalCost: plan.totalCalculatedCost,
          plan: plan.toModel(),
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
      },
      failure: (error) {
        _emitFailure(AddToTripStatus.generateFailure, error.message);
      },
      cancelled: () {},
    );
  }

  Future<void> createNewTripAndAdd({
    required List<String> userInterests,
  }) async {
    if (state.startDate == null || state.endDate == null) return;

    _emitStatus(AddToTripStatus.generatingNewTripPlan);

    final days = state.endDate!.difference(state.startDate!).inDays + 1;

    final request = GeneratePlanRequestModel(
      city: state.place.location.cityEn,
      days: days,
      people: state.adultCount,
      budget:
          int.tryParse(state.budget) ?? int.tryParse(state.customBudget) ?? 0,
      interests: userInterests
          .map((e) => InterestCategories.stripEmoji(e))
          .toList(),
      mustInclude: state.place.name,
    );

    final result = await _generatePlanUseCase(request: request);

    await result.when(
      success: (plan) async {
        _emitStatus(AddToTripStatus.creatingTrip);

        final collected = CollectedPlannerDataEntity(
          destination: state.place.location.cityEn,
          days: days,
          people: state.adultCount,
          budget:
              int.tryParse(state.budget) ??
              int.tryParse(state.customBudget) ??
              0,
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
      },
      failure: (error) {
        _emitFailure(AddToTripStatus.generateFailure, error.message);
      },
      cancelled: () {},
    );
  }

  void updateStartDate(DateTime? date) =>
      emitSafe(state.copyWith(startDate: date));

  void updateEndDate(DateTime? date) => emitSafe(state.copyWith(endDate: date));

  void updateAdults(int count) => emitSafe(state.copyWith(adultCount: count));

  void updateBudget(String value) {
    emitSafe(state.copyWith(budget: value, customBudget: ''));
  }

  void updateCustomBudget(String value) {
    emitSafe(state.copyWith(customBudget: value, budget: ''));
  }

  void setPage(int page) => emitSafe(state.copyWith(currentPage: page));
}
