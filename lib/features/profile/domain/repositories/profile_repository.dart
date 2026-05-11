import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';

abstract class ProfileRepository {
  Future<Result<void>> deleteAccount({CancelToken? cancelToken});
}
