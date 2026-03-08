import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_remote_data_source.dart';
import 'package:mindtrip/features/authetication/data/models/auth_response_model.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

/// [DATA LAYER] — Repository Implementation
///
/// [AuthRepositoryImpl] coordinates between:
///   • [AuthRemoteDataSource]  — network calls.
///   • [AuthLocalDataSource]   — token persistence.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  // ──────────────── Sign In ────────────────

  @override
  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponseModel response = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );

      await _localDataSource.saveTokens(accessToken: response.accessToken);

      return Result.ok(response.user.toEntity());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  // ──────────────── Sign Up ────────────────

  @override
  Future<Result<UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponseModel response = await _remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );

      await _localDataSource.saveTokens(accessToken: response.accessToken);

      return Result.ok(response.user.toEntity());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  // ──────────────── Logout ────────────────

  @override
  Future<Result<void>> logout() async {
    try {
      // Attempt server-side invalidation (best-effort).
      final accessToken = _localDataSource.getAccessToken();
      // await _remoteDataSource.logout(accessToken: accessToken);

      // Always clear local data regardless of server response.
      // await _localDataSource.clearAll();

      return const Result.ok(null);
    } catch (e) {
      // Even if the server call fails, clear local data to force re-login.
      // await _localDataSource.clearAll();
      return const Result.ok(null);
    }
  }

  // ──────────────── Refresh Token ────────────────

  // @override
  // Future<Result<AuthTokens>> refreshToken() async {
  //   try {
  //     final storedAccess = _localDataSource.getAccessToken();

  //     // if (storedAccess == null || storedAccess.isEmpty) {
  //     //   return const Result.error(
  //     //     UnauthorizedFailure(message: 'No access token available'),
  //     //   );
  //     // }

  //     final response = await _remoteDataSource.refreshToken(
  //       accessToken: storedAccess!,
  //     );

  //     // // Save the new token.
  //     // await _localDataSource.saveAccessToken(response.accessToken);

  //     return Result.ok(response.toAuthTokens());
  //   } catch (e) {
  //     // Token expired → user must re-login.
  //     // await _localDataSource.clearAll();
  //     return Result.error(
  //       UnauthorizedFailure(
  //         message: 'Session expired. Please sign in again.',
  //         debugMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }

  // ──────────────── Get Current User ────────────────

  // @override
  // Future<Result<UserEntity>> getCurrentUser() async {
  //   try {
  //     // Quick guard: if no token exists, there is no session.
  //     if (!_localDataSource.hasTokens()) {
  //       return const Result.error(
  //         UnauthorizedFailure(message: 'No active session'),
  //       );
  //     }

  //     final accessToken = _localDataSource.getAccessToken()!;

  //     final userModel = await _remoteDataSource.getCurrentUser(
  //       accessToken: accessToken,
  //     );

  //     // Update the locally cached user.
  //     await _localDataSource.saveCachedUser(userModel.toJsonString());

  //     return Result.ok(userModel.toEntity());
  //   } catch (e) {
  //     // If the access token is expired, try refreshing it first.
  //     final refreshResult = await refreshToken();

  //     return refreshResult.when(
  //       success: (_) async {
  //         // Retry getting the user with the new token.
  //         try {
  //           final newAccessToken = _localDataSource.getAccessToken()!;
  //           final userModel = await _remoteDataSource.getCurrentUser(
  //             accessToken: newAccessToken,
  //           );
  //           await _localDataSource.saveCachedUser(userModel.toJsonString());
  //           return Result.ok(userModel.toEntity());
  //         } catch (retryError) {
  //           return Result.error(
  //             ServerFailure(
  //               'Failed to fetch user after token refresh',
  //               debugMessage: retryError.toString(),
  //             ),
  //           );
  //         }
  //       },
  //       failure: (failure) => Result.error(failure),
  //     );
  //   }
  // }
}
