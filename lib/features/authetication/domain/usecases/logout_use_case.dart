import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [DOMAIN LAYER] — Use Case
///
/// [LogoutUseCase] encapsulates the action of signing a user out.
///
/// Clears all stored tokens and invalidates the session. Returns [Result<void>]
/// because there is no meaningful data on success — only success/failure.
/// ──────────────────────────────────────────────────────────────────────────────
class LogoutUseCase {
  final AuthRepository _repository;

  const LogoutUseCase({required AuthRepository repository})
    : _repository = repository;

  /// Execute the logout action.
  Future<Result<void>> call() {
    return _repository.logout();
  }
}
