import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/map/domain/repositories/google_places_repository.dart';
import 'package:mindtrip/features/map/domain/use_cases/fetch_place_photo_urls_use_case.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';

class MockGooglePlacesRepository extends Mock
    implements GooglePlacesRepository {}

void main() {
  late MapCubit cubit;
  late MockGooglePlacesRepository mockRepo;

  setUp(() {
    mockRepo = MockGooglePlacesRepository();
    when(
      () => mockRepo.fetchPlacePhotoUrls(
        any(),
        maxWidth: any(named: 'maxWidth'),
        cancelToken: any(named: 'cancelToken'),
      ),
    ).thenAnswer((_) async => const Result.ok([]));
    cubit = MapCubit(
      fetchPlacePhotoUrlsUseCase: FetchPlacePhotoUrlsUseCase(
        repository: mockRepo,
      ),
    );
  });

  tearDown(() {
    cubit.close();
  });

  final tPlace = PlaceEntity(
    id: '1',
    name: 'Test Place',
    location: LocationEntity(address: '', latitude: 10.0, longitude: 20.0),
    description: 'A test place',
    category: PlaceCategory.cafe,
    rating: 4.5,
  );

  group('MapCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, MapState.initial());
    });

    test('loadPlaces updates annotations', () {
      cubit.loadPlaces([tPlace]);
      expect(cubit.state.annotations.length, 1);
      expect(cubit.state.annotations.first.place.id, '1');
    });

    test('selectPlace updates selectedPlace and shows bottom sheet', () {
      cubit.loadPlaces([tPlace]);
      cubit.selectPlace('1');
      expect(cubit.state.selectedPlace, tPlace);
      expect(cubit.state.isBottomSheetVisible, true);
    });

    test('dismissBottomSheet sets isBottomSheetVisible to false', () {
      cubit.loadPlaces([tPlace]);
      cubit.selectPlace('1');
      expect(cubit.state.isBottomSheetVisible, true);
      cubit.dismissBottomSheet();
      expect(cubit.state.isBottomSheetVisible, false);
    });

    test('setLocationGranted updates state correctly', () {
      expect(cubit.state.isLocationGranted, false);
      cubit.setLocationGranted(true);
      expect(cubit.state.isLocationGranted, true);
    });

    test('triggerFlyTo updates lat/lng and increments flyToPulse', () {
      expect(cubit.state.flyToPulse, 0);
      cubit.triggerFlyTo(40.0, 50.0);
      expect(cubit.state.flyToLat, 40.0);
      expect(cubit.state.flyToLng, 50.0);
      expect(cubit.state.flyToPulse, 1);

      // Triggering to the same location still increments pulse
      cubit.triggerFlyTo(40.0, 50.0);
      expect(cubit.state.flyToPulse, 2);
    });
  });
}
