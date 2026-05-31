import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/place_details/domain/use_cases/get_nearby_places_use_case.dart';
import 'package:mindtrip/features/place_details/domain/use_cases/get_place_details_use_case.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_cubit.dart';
import 'package:mindtrip/features/place_details/presentation/cubit/place_details_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPlaceDetailsUseCase extends Mock
    implements GetPlaceDetailsUseCase {}

class MockGetNearbyPlacesUseCase extends Mock
    implements GetNearbyPlacesUseCase {}

void main() {
  late PlaceDetailsCubit cubit;
  late MockGetPlaceDetailsUseCase mockGetDetails;
  late MockGetNearbyPlacesUseCase mockGetNearby;

  final tPlace = PlaceEntity(
    id: '1',
    name: 'Test Place',
    location: const LocationEntity(
      address: '123 Test St',
      latitude: 0.0,
      longitude: 0.0,
    ),
  );

  final tPreviewPlace = PlaceEntity(
    id: '1',
    name: 'Preview Place',
    location: const LocationEntity(
      address: '123 Test St',
      latitude: 0.0,
      longitude: 0.0,
    ),
  );

  setUp(() {
    mockGetDetails = MockGetPlaceDetailsUseCase();
    mockGetNearby = MockGetNearbyPlacesUseCase();
    cubit = PlaceDetailsCubit(
      getDetails: mockGetDetails,
      getNearby: mockGetNearby,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('loadPlaceDetails', () {
    test('emits [loading, loaded] when okful', () async {
      when(
        () => mockGetDetails('1'),
      ).thenAnswer((_) async => Result.ok(tPlace));

      final expectedStates = [
        const PlaceDetailsState(status: PlaceDetailsStatus.loading),
        PlaceDetailsState(status: PlaceDetailsStatus.loaded, place: tPlace),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadPlaceDetails('1');
      verify(() => mockGetDetails('1')).called(1);
    });

    test('emits preview first, then full details when preview is provided', () async {
      when(
        () => mockGetDetails('1'),
      ).thenAnswer((_) async => Result.ok(tPlace));

      final expectedStates = [
        PlaceDetailsState(
          status: PlaceDetailsStatus.loading,
          preview: tPreviewPlace,
          place: tPreviewPlace,
        ),
        PlaceDetailsState(
          status: PlaceDetailsStatus.loaded,
          preview: tPreviewPlace,
          place: tPlace,
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadPlaceDetails('1', preview: tPreviewPlace);
    });

    test('emits [loading, error] when unokful', () async {
      when(
        () => mockGetDetails('1'),
      ).thenAnswer((_) async => Result.error(ServerFailure('Server Error')));

      final expectedStates = [
        const PlaceDetailsState(status: PlaceDetailsStatus.loading),
        const PlaceDetailsState(
          status: PlaceDetailsStatus.error,
          errorMessage: 'Server Error',
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadPlaceDetails('1');
    });
  });

  group('loadNearbyPlaces', () {
    final tPlacesList = [tPlace];

    test('emits loading and then loaded state with nearby places', () async {
      when(
        () => mockGetNearby('1', lat: null, lng: null),
      ).thenAnswer((_) async => Result.ok(tPlacesList));

      final expectedStates = [
        const PlaceDetailsState(isNearbyLoading: true),
        PlaceDetailsState(isNearbyLoading: false, nearbyPlaces: tPlacesList),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadNearbyPlaces('1');
    });

    test('emits loading and then error state', () async {
      when(
        () => mockGetNearby('1', lat: null, lng: null),
      ).thenAnswer((_) async => Result.error(ServerFailure('Nearby Error')));

      final expectedStates = [
        const PlaceDetailsState(isNearbyLoading: true),
        const PlaceDetailsState(
          isNearbyLoading: false,
          errorMessage: 'Nearby Error',
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadNearbyPlaces('1');
    });
  });
}
