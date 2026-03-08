import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [DOMAIN LAYER] — Use Case
///
/// [SignInUseCase] encapsulates the single action of signing a user in.
///
/// Use-cases are the **only** entry-point into the domain for the presentation
/// layer. Each use-case owns exactly one business rule, making them trivially
/// testable and composable.
/// ──────────────────────────────────────────────────────────────────────────────
class SignInUseCase {
  final AuthRepository _repository;

  /// Injected via constructor — no service locator calls inside use-cases.
  const SignInUseCase({required AuthRepository repository})
    : _repository = repository;

  /// Execute the sign-in action.
  Future<Result<UserEntity>> call({
    required String email,
    required String password,
  }) {
    return _repository.signIn(email: email, password: password);
  }
}
