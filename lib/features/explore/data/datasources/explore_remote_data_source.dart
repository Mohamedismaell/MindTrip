import 'package:mindtrip/core/database/api/api_consumer.dart';

abstract class ExploreRemoteDataSource {}

class ExploreRemoteDataSourceImpl implements ExploreRemoteDataSource {
  final ApiConsumer _api;

  ExploreRemoteDataSourceImpl({required ApiConsumer api}) : _api = api;
}
