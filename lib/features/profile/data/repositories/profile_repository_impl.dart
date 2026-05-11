import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mindtrip/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _datasource;

  ProfileRepositoryImpl({required ProfileRemoteDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Result<void>> deleteAccount({CancelToken? cancelToken}) async {
    try {
      await _datasource.deleteAccount(cancelToken: cancelToken);
      return Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
