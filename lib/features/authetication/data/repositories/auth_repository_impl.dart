import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_remote_data_source.dart';
import 'package:mindtrip/features/authetication/data/models/auth_response_model.dart';
import 'package:mindtrip/features/authetication/data/models/resete_password_model.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/entities/verify_password_otp_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  //  Sign In

  @override
  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final AuthResponseModel response = await _remoteDataSource.signIn(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      await _localDataSource.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return Result.ok(response.user.toEntity());
    } catch (e) {
      print('Error here ===== > $e');
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  //  Sign Up

  @override
  Future<Result<void>> signUp({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      await _remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  //Gooogle

  @override
  Future<Result<UserEntity>> googleAuth({required String token}) async {
    try {
      final response = await _remoteDataSource.signInWithGoogle(idToken: token);

      await _localDataSource.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return Result.ok(response.user.toEntity());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
  //  Logout

  @override
  Future<Result<void>> logout() async {
    try {
      // Attempt server-side invalidation (best-effort).
      // final accessToken = _localDataSource.getAccessToken();
      // await _remoteDataSource.logout(accessToken: accessToken);

      await _localDataSource.clear();

      return const Result.ok(null);
    } catch (e) {
      await _localDataSource.clear();
      return const Result.ok(null);
    }
  }

  @override
  Future<Result<UserEntity>> facebookAuth({required String token}) async {
    try {
      final response = await _remoteDataSource.signInWithFacebook(
        accessToken: token,
      );

      await _localDataSource.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return Result.ok(response.user.toEntity());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> forgetPassword({required String email}) async {
    try {
      await _remoteDataSource.forgetPassword(email: email);

      return Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  //! reset Token and message Care......................
  @override
  Future<Result<VerifyPasswordOtpEntity>> verifyPasswordOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final resetToken = await _remoteDataSource.verifyPasswordOtp(
        email: email,
        otp: otp,
      );

      return Result.ok(resetToken.toEntity());
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<ResetePasswordModel>> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await _remoteDataSource.resetPassword(
        email: email,
        resetToken: resetToken,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

      return Result.ok(response);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> resendPasswordOtp({required String email}) async {
    try {
      await _remoteDataSource.resendPasswordOtp(email: email);

      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  //  Verify Email (after sign up)

  @override
  Future<Result<void>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      await _remoteDataSource.verifyEmail(email: email, otp: otp);

      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  //  Resend Email OTP

  @override
  Future<Result<void>> resendEmailOtp({required String email}) async {
    try {
      await _remoteDataSource.resendEmailOtp(email: email);

      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  //  Refresh Token

  @override
  Future<Result<UserEntity>> refreshToken() async {
    try {
      final storedRefreshToken = await _localDataSource.getRefreshToken();

      if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
        return const Result.error(
          UnauthorizedFailure(message: 'No refresh token available'),
        );
      }

      final response = await _remoteDataSource.refreshToken(
        refreshToken: storedRefreshToken,
      );

      await _localDataSource.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return Result.ok(response.user.toEntity());
    } catch (e) {
      // Refresh token is expired or invalid — force the user to re-login.
      await _localDataSource.clear();
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  //  Get Current User

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
