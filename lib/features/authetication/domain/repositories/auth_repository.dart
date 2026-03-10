import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<Result<UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<Result<void>> logout();

  // Future<Result<AuthTokens>> refreshToken();

  // Future<Result<UserEntity>> getCurrentUser();
}
