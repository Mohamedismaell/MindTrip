import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/add_place_to_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_between_trips_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_in_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/remove_place_from_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockTripRepository extends Mock implements TripRepository {}

class MockAddPlaceToTripUseCase extends Mock implements AddPlaceToTripUseCase {}

class MockRemovePlaceFromTripUseCase extends Mock
    implements RemovePlaceFromTripUseCase {}

class MockMovePlaceInTripUseCase extends Mock
    implements MovePlaceInTripUseCase {}

class MockMovePlaceBetweenTripsUseCase extends Mock
    implements MovePlaceBetweenTripsUseCase {}

void main() {
  late AddToTripCubit cubit;
  late MockTripRepository mockRepo;
  late MockAddPlaceToTripUseCase mockAddPlace;
  late MockRemovePlaceFromTripUseCase mockRemovePlace;
  late MockMovePlaceInTripUseCase mockMoveInTrip;
  late MockMovePlaceBetweenTripsUseCase mockMoveBetweenTrips;
  late PlaceEntity testPlace;
  late Trip testTrip;

  setUp(() {
    mockRepo = MockTripRepository();
    mockAddPlace = MockAddPlaceToTripUseCase();
    mockRemovePlace = MockRemovePlaceFromTripUseCase();
    mockMoveInTrip = MockMovePlaceInTripUseCase();
    mockMoveBetweenTrips = MockMovePlaceBetweenTripsUseCase();
    testPlace = const PlaceEntity(
      id: 'place1',
      name: 'Test Place',
      location: LocationEntity(address: 'Test', latitude: 0.0, longitude: 0.0),
      category: PlaceCategory.activity,
    );
    testTrip = Trip(
      id: 'trip1',
      title: 'Test Trip',
      destination: 'Test Destination',
      adults: 1,
      children: 0,
      pets: 0,
      budgetTier: 'Cheap',
      customBudget: '',
      interests: const [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: TripStatus.inProgress,
    );

    cubit = AddToTripCubit(
      place: testPlace,
      tripRepository: mockRepo,
      addPlaceUseCase: mockAddPlace,
      removePlaceUseCase: mockRemovePlace,
      movePlaceInTripUseCase: mockMoveInTrip,
      movePlaceBetweenTripsUseCase: mockMoveBetweenTrips,
    );
  });

  group('AddToTripCubit', () {
    test('initial state has correct place', () {
      expect(cubit.state.place, testPlace);
      expect(cubit.state.status, AddToTripStatus.initial);
    });

    test('init sets placeAlreadyInTrip successfully', () async {
      when(
        () => mockRepo.getTripContainingPlace('place1'),
      ).thenAnswer((_) async => testTrip);

      await cubit.init();

      expect(cubit.state.placeAlreadyInTrip, true);
      expect(cubit.state.hostTripName, 'Test Trip');
      expect(cubit.state.hostTripId, 'trip1');
    });

    test('loadTrips emits loadingTrips then selectTrip with trips', () async {
      when(() => mockRepo.getAllTrips()).thenAnswer((_) async => [testTrip]);

      await cubit.loadTrips();

      expect(cubit.state.status, AddToTripStatus.selectTrip);
      expect(cubit.state.trips, [testTrip]);
    });
  });
}
