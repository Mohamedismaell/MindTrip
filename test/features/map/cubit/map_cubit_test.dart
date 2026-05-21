import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/map/domain/entities/map_annotation_entry.dart';
import 'package:mindtrip/features/map/domain/entities/map_route.dart';
import 'package:mindtrip/features/map/domain/entities/map_search_result.dart';
import 'package:mindtrip/features/map/domain/entities/search_suggestion.dart';
import 'package:mindtrip/features/map/domain/repositories/map_route_repository.dart';
import 'package:mindtrip/features/map/domain/repositories/map_search_repository.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';

class MockMapSearchRepository extends Mock implements MapSearchRepository {}

class MockMapRouteRepository extends Mock implements MapRouteRepository {}

void main() {
  late MapCubit cubit;
  late MockMapSearchRepository mockSearchRepo;
  late MockMapRouteRepository mockRouteRepo;

  setUp(() {
    mockSearchRepo = MockMapSearchRepository();
    mockRouteRepo = MockMapRouteRepository();
    cubit = MapCubit(searchRepo: mockSearchRepo, routeRepo: mockRouteRepo);
  });

  tearDown(() {
    cubit.close();
  });

  final tPlace = PlaceModel(
    id: '1',
    name: 'Test Place',
    location: LocationModel(latitude: 10.0, longitude: 20.0),
    description: 'A test place',
    category: 'Cafe',
    rating: 4.5,
  );

  group('MapCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, MapState.initial());
    });

    blocTest<MapCubit, MapState>(
      'emits updated annotations when loadPlaces is called',
      build: () => cubit,
      act: (cubit) => cubit.loadPlaces([tPlace]),
      expect: () => [
        isA<MapState>()
            .having((s) => s.annotations.length, 'annotations length', 1)
            .having(
              (s) => s.annotations.first.place.id,
              'annotation place id',
              '1',
            ),
      ],
    );

    blocTest<MapCubit, MapState>(
      'selectPlace updates selectedPlace and shows bottom sheet',
      build: () => cubit,
      seed: () => MapState.initial().copyWith(
        annotations: [MapAnnotationEntry(place: tPlace, sequenceNumber: 1)],
      ),
      act: (cubit) => cubit.selectPlace('1'),
      expect: () => [
        isA<MapState>()
            .having((s) => s.selectedPlace, 'selectedPlace', tPlace)
            .having(
              (s) => s.isBottomSheetVisible,
              'isBottomSheetVisible',
              true,
            ),
      ],
    );

    blocTest<MapCubit, MapState>(
      'dismissBottomSheet sets isBottomSheetVisible to false',
      build: () => cubit,
      seed: () => MapState.initial().copyWith(isBottomSheetVisible: true),
      act: (cubit) => cubit.dismissBottomSheet(),
      expect: () => [
        isA<MapState>().having(
          (s) => s.isBottomSheetVisible,
          'isBottomSheetVisible',
          false,
        ),
      ],
    );

    blocTest<MapCubit, MapState>(
      'setLocationGranted updates state correctly',
      build: () => cubit,
      act: (cubit) => cubit.setLocationGranted(true),
      expect: () => [
        isA<MapState>().having(
          (s) => s.isLocationGranted,
          'isLocationGranted',
          true,
        ),
      ],
    );
  });
}
