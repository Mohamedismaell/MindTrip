import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [DOMAIN LAYER] — Use Case
///
/// [SignUpUseCase] encapsulates the single action of registering a new user.
///
/// It takes a [name], [email], and [password], forwards them to the repository,
/// and returns either a [UserEntity] on success or a [Failure] on error.
/// ──────────────────────────────────────────────────────────────────────────────
class SignUpUseCase {
  final AuthRepository _repository;

  const SignUpUseCase({required AuthRepository repository})
    : _repository = repository;

  /// Execute the sign-up action.
  Future<Result<UserEntity>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.signUp(name: name, email: email, password: password);
  }
}
