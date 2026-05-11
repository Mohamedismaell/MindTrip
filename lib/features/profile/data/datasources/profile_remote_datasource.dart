import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';

class ProfileRemoteDatasource {
  final ApiConsumer _apiConsumer;

  ProfileRemoteDatasource({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  Future<void> deleteAccount({CancelToken? cancelToken}) async {
    await _apiConsumer.delete(
      EndPoints.deleteAccount,
      cancelToken: cancelToken,
    );
  }
}
