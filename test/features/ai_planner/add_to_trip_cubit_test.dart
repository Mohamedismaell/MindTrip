import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/add_place_to_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/generate_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/get_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_between_trips_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_in_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/remove_place_from_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/save_itinerary_use_case.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_by_id_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_containing_place_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/save_trip_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTripContainingPlaceUseCase extends Mock
    implements GetTripContainingPlaceUseCase {}

class MockGetAllTripsUseCase extends Mock implements GetAllTripsUseCase {}

class MockGetItineraryUseCase extends Mock implements GetItineraryUseCase {}

class MockAddPlaceToTripUseCase extends Mock implements AddPlaceToTripUseCase {}

class MockRemovePlaceFromTripUseCase extends Mock
    implements RemovePlaceFromTripUseCase {}

class MockMovePlaceInTripUseCase extends Mock
    implements MovePlaceInTripUseCase {}

class MockMovePlaceBetweenTripsUseCase extends Mock
    implements MovePlaceBetweenTripsUseCase {}

class MockGetTripByIdUseCase extends Mock implements GetTripByIdUseCase {}

class MockSaveTripUseCase extends Mock implements SaveTripUseCase {}

class MockGenerateItineraryUseCase extends Mock
    implements GenerateItineraryUseCase {}

class MockSaveItineraryUseCase extends Mock implements SaveItineraryUseCase {}

void main() {
  late AddToTripCubit cubit;
  late MockGetTripContainingPlaceUseCase mockGetTripContainingPlace;
  late MockGetAllTripsUseCase mockGetAllTrips;
  late MockGetItineraryUseCase mockGetItinerary;
  late MockAddPlaceToTripUseCase mockAddPlace;
  late MockRemovePlaceFromTripUseCase mockRemovePlace;
  late MockMovePlaceInTripUseCase mockMoveInTrip;
  late MockMovePlaceBetweenTripsUseCase mockMoveBetweenTrips;
  late MockGetTripByIdUseCase mockGetTripById;
  late MockSaveTripUseCase mockSaveTrip;
  late MockGenerateItineraryUseCase mockGenerateItinerary;
  late MockSaveItineraryUseCase mockSaveItinerary;

  late PlaceEntity testPlace;
  late Trip testTrip;
  late TripItinerary testItinerary;

  AddToTripCubit buildCubit() {
    return AddToTripCubit(
      place: testPlace,
      getTripContainingPlace: mockGetTripContainingPlace,
      getAllTrips: mockGetAllTrips,
      getItinerary: mockGetItinerary,
      addPlaceUseCase: mockAddPlace,
      removePlaceUseCase: mockRemovePlace,
      movePlaceInTripUseCase: mockMoveInTrip,
      movePlaceBetweenTripsUseCase: mockMoveBetweenTrips,
      getTripById: mockGetTripById,
      saveTrip: mockSaveTrip,
      generateItinerary: mockGenerateItinerary,
      saveItinerary: mockSaveItinerary,
    );
  }

  setUp(() {
    mockGetTripContainingPlace = MockGetTripContainingPlaceUseCase();
    mockGetAllTrips = MockGetAllTripsUseCase();
    mockGetItinerary = MockGetItineraryUseCase();
    mockAddPlace = MockAddPlaceToTripUseCase();
    mockRemovePlace = MockRemovePlaceFromTripUseCase();
    mockMoveInTrip = MockMovePlaceInTripUseCase();
    mockMoveBetweenTrips = MockMovePlaceBetweenTripsUseCase();
    mockGetTripById = MockGetTripByIdUseCase();
    mockSaveTrip = MockSaveTripUseCase();
    mockGenerateItinerary = MockGenerateItineraryUseCase();
    mockSaveItinerary = MockSaveItineraryUseCase();

    testPlace = const PlaceEntity(
      id: 'place1',
      name: 'Test Place',
      location: LocationEntity(address: 'Test', latitude: 0, longitude: 0),
      category: PlaceCategory.activity,
    );
    testTrip = Trip(
      id: 'trip1',
      title: 'Test Trip',
      destination: 'Test Destination',
      adults: 1,
      children: 0,
      budgetTier: 'Cheap',
      customBudget: '',
      interests: const [],
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
      status: TripStatus.inProgress,
    );
    testItinerary = const TripItinerary(
      tripId: 'trip1',
      days: [],
      estimatedTotalCost: 0,
    );

    cubit = buildCubit();
  });

  tearDown(() => cubit.close());

  group('AddToTripCubit', () {
    test('initial state has correct place and no selected trip', () {
      expect(cubit.state.place, testPlace);
      expect(cubit.state.selectedTrip, isNull);
      expect(cubit.state.tripsStatus, TripsLoadStatus.initial);
    });

    test('init sets placeAlreadyInTrip successfully', () async {
      when(
        () => mockGetTripContainingPlace('place1'),
      ).thenAnswer((_) async => Result.ok(testTrip));

      await cubit.init();

      expect(cubit.state.placeAlreadyInTrip, true);
      expect(cubit.state.hostTripName, 'Test Trip');
      expect(cubit.state.hostTripId, 'trip1');
    });

    test('loadTrips stores active trips', () async {
      when(
        () => mockGetAllTrips(),
      ).thenAnswer((_) async => Result.ok([testTrip]));

      await cubit.loadTrips();

      expect(cubit.state.tripsStatus, TripsLoadStatus.loaded);
      expect(cubit.state.trips, [testTrip]);
    });

    test(
      'selectTrip returns true and stores itinerary when load succeeds',
      () async {
        when(
          () => mockGetItinerary('trip1'),
        ).thenAnswer((_) async => Result.ok(testItinerary));

        final didLoad = await cubit.selectTrip(testTrip);

        expect(didLoad, true);
        expect(cubit.state.itineraryStatus, TripsLoadStatus.loaded);
        expect(cubit.state.selectedTrip, testTrip);
        expect(cubit.state.selectedItinerary, testItinerary);
      },
    );

    test(
      'loadHostTripItinerary loads host trip then selected itinerary',
      () async {
        when(
          () => mockGetTripContainingPlace('place1'),
        ).thenAnswer((_) async => Result.ok(testTrip));
        when(
          () => mockGetTripById('trip1'),
        ).thenAnswer((_) async => Result.ok(testTrip));
        when(
          () => mockGetItinerary('trip1'),
        ).thenAnswer((_) async => Result.ok(testItinerary));

        await cubit.init();
        final didLoad = await cubit.loadHostTripItinerary();

        expect(didLoad, true);
        expect(cubit.state.selectedTrip, testTrip);
        expect(cubit.state.selectedItinerary, testItinerary);
      },
    );

    test(
      'addToTrip updates host trip and clears selection on success',
      () async {
        when(
          () => mockGetItinerary('trip1'),
        ).thenAnswer((_) async => Result.ok(testItinerary));
        when(
          () => mockAddPlace(
            tripId: 'trip1',
            place: testPlace,
            dayNumber: null,
            period: null,
          ),
        ).thenAnswer((_) async => Result.ok(testItinerary));

        await cubit.selectTrip(testTrip);
        await cubit.addToTrip();

        expect(cubit.state.addingStatus, ActionStatus.success);
        expect(cubit.state.placeAlreadyInTrip, true);
        expect(cubit.state.hostTripId, 'trip1');
        expect(cubit.state.selectedTrip, isNull);
        expect(cubit.state.selectedItinerary, isNull);
      },
    );

    test('removeFromTrip clears host trip on success', () async {
      when(
        () => mockGetTripContainingPlace('place1'),
      ).thenAnswer((_) async => Result.ok(testTrip));
      when(
        () => mockRemovePlace(tripId: 'trip1', placeId: 'place1'),
      ).thenAnswer((_) async => Result.ok(testItinerary));

      await cubit.init();
      await cubit.removeFromTrip();

      expect(cubit.state.addingStatus, ActionStatus.success);
      expect(cubit.state.placeAlreadyInTrip, false);
      expect(cubit.state.hostTripId, isNull);
      expect(cubit.state.hostTripName, isNull);
    });
  });
}
