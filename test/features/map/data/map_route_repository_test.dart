import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Error;
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/features/map/data/datasources/map_route_remote_datasource.dart';
import 'package:mindtrip/features/map/data/repositories/map_route_repository_impl.dart';
import 'package:mindtrip/features/map/domain/entities/map_route.dart';
import 'package:mindtrip/features/map/domain/entities/navigation_profile.dart';

class MockMapRouteRemoteDatasource extends Mock
    implements MapRouteRemoteDatasource {}

void main() {
  late MapRouteRepositoryImpl repository;
  late MockMapRouteRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockMapRouteRemoteDatasource();
    repository = MapRouteRepositoryImpl(datasource: mockDatasource);
    registerFallbackValue(NavigationProfile.driving);
  });

  group('getRoute', () {
    final tWaypoints = [Position(20.0, 10.0), Position(21.0, 11.0)];
    final tRoute = MapRoute(
      waypoints: tWaypoints,
      geoJsonGeometry: '{"type":"LineString","coordinates":[]}',
      distance: 100.0,
      duration: 50.0,
      legs: [],
      profile: NavigationProfile.driving,
    );

    test('should return route on success', () async {
      when(
        () => mockDatasource.getRoute(
          tWaypoints,
          any(),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => tRoute);

      final result = await repository.getRoute(tWaypoints);

      expect(result, isA<Ok<MapRoute>>());
      result.when(
        success: (data) => expect(data, equals(tRoute)),
        failure: (_) => fail('Should be success'),
      );
      verify(
        () => mockDatasource.getRoute(tWaypoints, NavigationProfile.driving),
      ).called(1);
    });

    test('should return UnknownFailure on exception', () async {
      when(
        () => mockDatasource.getRoute(
          tWaypoints,
          any(),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenThrow(Exception('Error'));

      final result = await repository.getRoute(tWaypoints);

      expect(result, isA<Error<MapRoute>>());
      result.when(
        success: (_) => fail('Should be failure'),
        failure: (error) => expect(error, isA<UnknownFailure>()),
      );
      verify(
        () => mockDatasource.getRoute(tWaypoints, NavigationProfile.driving),
      ).called(1);
    });
  });
}
