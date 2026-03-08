import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [DOMAIN LAYER] — Use Case
///
/// [GetCurrentUserUseCase] retrieves the currently authenticated user.
///
/// This is used during app startup (auto-login flow) to check if valid tokens
/// exist and, if so, fetch the associated user profile without requiring the
/// user to sign in again.
/// ──────────────────────────────────────────────────────────────────────────────
class GetCurrentUserUseCase {
  final AuthRepository _repository;

  const GetCurrentUserUseCase({required AuthRepository repository})
    : _repository = repository;

  // Future<Result<UserEntity>> call() {
  //   return _repository.getCurrentUser();
  // }
}
