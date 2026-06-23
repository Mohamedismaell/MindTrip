import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/user/data/datasources/user_remote_data_source.dart';
import 'package:mindtrip/features/user/domain/repositories/user_repository.dart';
import 'package:mindtrip/features/user/data/mapper/user_mapper.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl({required UserRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<UserEntity>> getCurrentUser() async {
    try {
      final user = await _remoteDataSource.getCurrentUser();
      return Result.ok(user.toEntity());
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> updateInterests(List<String> interests) async {
    try {
      await _remoteDataSource.updateInterests(interests);
      return const Result.ok(null);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<String>> uploadProfilePhoto(String filePath) async {
    try {
      final url = await _remoteDataSource.uploadProfilePhoto(filePath);
      return Result.ok(url);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> updateProfile({
    String? displayName,
    String? phoneNumber,
  }) async {
    try {
      await _remoteDataSource.updateProfile(
        displayName: displayName,
        phoneNumber: phoneNumber,
      );
      return const Result.ok(null);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
