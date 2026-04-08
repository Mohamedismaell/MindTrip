import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<Result<void>> signUp({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<Result<UserEntity>> googleAuth({required String token});

  Future<Result<UserEntity>> facebookAuth({required String token});

  Future<Result<void>> forgetPassword({required String email});
  
  Future<Result<String>> verifyOtp({required String email, required String otp});

  Future<Result<void>> resetPassword({required String resetToken, required String newPassword});

  Future<Result<void>> resendPasswordOtp({required String email});

  Future<Result<void>> verifyEmail({required String email, required String otp});

  Future<Result<void>> resendEmailOtp({required String email});

  Future<Result<void>> logout();

  // Future<Result<AuthTokens>> refreshToken();

  // Future<Result<UserEntity>> getCurrentUser();
}
