import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/features/map/data/datasources/map_search_remote_datasource.dart';
import 'package:mindtrip/features/map/data/repositories/map_search_repository_impl.dart';
import 'package:mindtrip/features/map/domain/entities/search_suggestion.dart';
import 'package:mindtrip/features/map/domain/entities/map_search_result.dart';

class MockMapSearchRemoteDatasource extends Mock
    implements MapSearchRemoteDatasource {}

void main() {
  late MapSearchRepositoryImpl repository;
  late MockMapSearchRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockMapSearchRemoteDatasource();
    repository = MapSearchRepositoryImpl(datasource: mockDatasource);
  });

  group('suggest', () {
    final tQuery = 'cafe';
    final tToken = 'token123';
    final tSuggestions = [
      SearchSuggestion(
        mapboxId: '1',
        name: 'Cafe 1',
        placeFormatted: 'Address 1',
      ),
    ];

    test('should return suggestions on success', () async {
      when(
        () => mockDatasource.suggest(tQuery, tToken),
      ).thenAnswer((_) async => tSuggestions);

      final result = await repository.suggest(tQuery, tToken);

      expect(result, isA<Success<List<SearchSuggestion>, Failure>>());
      result.when(
        success: (data) => expect(data, equals(tSuggestions)),
        failure: (_) => fail('Should be success'),
      );
      verify(() => mockDatasource.suggest(tQuery, tToken)).called(1);
    });

    test('should return NetworkFailure on exception', () async {
      when(
        () => mockDatasource.suggest(tQuery, tToken),
      ).thenThrow(Exception('Network Error'));

      final result = await repository.suggest(tQuery, tToken);

      expect(result, isA<FailureResult<List<SearchSuggestion>, Failure>>());
      result.when(
        success: (_) => fail('Should be failure'),
        failure: (error) => expect(error, isA<NetworkFailure>()),
      );
      verify(() => mockDatasource.suggest(tQuery, tToken)).called(1);
    });
  });

  group('retrieve', () {
    final tId = 'mapboxId1';
    final tToken = 'token123';
    final tResult = MapSearchResult(
      name: 'Cafe 1',
      latitude: 10.0,
      longitude: 20.0,
      address: 'Address 1',
    );

    test('should return search result on success', () async {
      when(
        () => mockDatasource.retrieve(tId, tToken),
      ).thenAnswer((_) async => tResult);

      final result = await repository.retrieve(tId, tToken);

      expect(result, isA<Success<MapSearchResult, Failure>>());
      result.when(
        success: (data) => expect(data, equals(tResult)),
        failure: (_) => fail('Should be success'),
      );
      verify(() => mockDatasource.retrieve(tId, tToken)).called(1);
    });

    test('should return NetworkFailure on exception', () async {
      when(
        () => mockDatasource.retrieve(tId, tToken),
      ).thenThrow(Exception('Network Error'));

      final result = await repository.retrieve(tId, tToken);

      expect(result, isA<FailureResult<MapSearchResult, Failure>>());
      result.when(
        success: (_) => fail('Should be failure'),
        failure: (error) => expect(error, isA<NetworkFailure>()),
      );
      verify(() => mockDatasource.retrieve(tId, tToken)).called(1);
    });
  });
}
