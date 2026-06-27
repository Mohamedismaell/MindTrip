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

class AddToTripCubit extends SafeCubit<AddToTripState> {
  final GetAllTripsUseCase _getAllTripsUseCase;
  final EditPlanUseCase _editPlanUseCase;
  final GeneratePlanUseCase _generatePlanUseCase;
  final CreateTripUseCase _createTripUseCase;

  AddToTripCubit({
    required PlaceEntity place,
    required GetAllTripsUseCase getAllTripsUseCase,
    required EditPlanUseCase editPlanUseCase,
    required GeneratePlanUseCase generatePlanUseCase,
    required CreateTripUseCase createTripUseCase,
  }) : _getAllTripsUseCase = getAllTripsUseCase,
       _editPlanUseCase = editPlanUseCase,
       _generatePlanUseCase = generatePlanUseCase,
       _createTripUseCase = createTripUseCase,
       super(AddToTripState(place: place));

  Future<void> loadTrips() async {
    emitSafe(state.copyWith(status: AddToTripStatus.loading));
    final result = await _getAllTripsUseCase();
    result.when(
      success: (trips) {
        emitSafe(state.copyWith(
          status: AddToTripStatus.initial,
          trips: trips.where((t) => t.status != TripStatus.completed).toList(),
        ));
      },
      failure: (error) {
        emitSafe(state.copyWith(
          status: AddToTripStatus.failure,
          errorMessage: error.message,
        ));
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

    emitSafe(state.copyWith(status: AddToTripStatus.loading));

    final request = EditPlanRequestModel(
      targetChange: 'Add ${state.place.name} to the itinerary',
      destination: trip.city.isNotEmpty ? trip.city : trip.destinationGovernorate,
      city: trip.city.isNotEmpty ? trip.city : trip.destinationGovernorate,
      days: trip.plan.daysCount,
      budget: trip.plan.totalCalculatedCost.toInt(),
      people: trip.people,
      interests: trip.collected?.interests ?? [],
      existingPlan: trip.plan.toModels(),
      mode: 'add',
      item: ItemToEdit(
        placeId: state.place.id,
        name: state.place.name,
      ),
      tripId: trip.tripId,
    );

    final result = await _editPlanUseCase(request: request);
    result.when(
      success: (response) async {
        if (response.plan != null) {
          // In a real app, we'd save the updated plan back to the trip
          // For now, we'll assume the backend handles the persistence or we need to call a "save" endpoint
          // But according to the flow, AI Edit might just return the new plan.
          emitSafe(state.copyWith(status: AddToTripStatus.success));
        } else {
          emitSafe(state.copyWith(
            status: AddToTripStatus.failure,
            errorMessage: response.message ?? 'Failed to add place.',
          ));
        }
      },
      failure: (error) {
        emitSafe(state.copyWith(
          status: AddToTripStatus.failure,
          errorMessage: error.message,
        ));
      },
      cancelled: () {},
    );
  }

  Future<void> createNewTripAndAdd() async {
    if (state.startDate == null || state.endDate == null) return;

    emitSafe(state.copyWith(status: AddToTripStatus.loading));

    final days = state.endDate!.difference(state.startDate!).inDays + 1;
    
    final request = GeneratePlanRequestModel(
      city: state.place.location.address, // Or city from place
      days: days,
      people: state.adultCount + state.childCount,
      budget: int.tryParse(state.budget) ?? 0,
      interests: [], // User would need to pick these, or we default
      mustInclude: state.place.name,
    );

    final result = await _generatePlanUseCase(request: request);
    result.when(
      success: (plan) async {
        // Now save the trip
        final collected = CollectedPlannerDataEntity(
          destination: state.place.location.address,
          days: days,
          people: state.adultCount + state.childCount,
          budget: int.tryParse(state.budget) ?? 0,
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
            emitSafe(state.copyWith(status: AddToTripStatus.success));
          },
          failure: (error) {
             emitSafe(state.copyWith(
              status: AddToTripStatus.failure,
              errorMessage: error.message,
            ));
          },
          cancelled: () {},
        );
      },
      failure: (error) {
        emitSafe(state.copyWith(
          status: AddToTripStatus.failure,
          errorMessage: error.message,
        ));
      },
      cancelled: () {},
    );
  }

  void updateStartDate(DateTime? date) => emitSafe(state.copyWith(startDate: date));
  void updateEndDate(DateTime? date) => emitSafe(state.copyWith(endDate: date));
  void updateAdults(int count) => emitSafe(state.copyWith(adultCount: count));
  void updateChildren(int count) => emitSafe(state.copyWith(childCount: count));
  void updateBudget(String budget) => emitSafe(state.copyWith(budget: budget));
  void setPage(int page) => emitSafe(state.copyWith(currentPage: page));
}
