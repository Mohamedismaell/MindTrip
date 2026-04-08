import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  const SignUpUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<void>> call({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    return _repository.signUp(
      name: name,
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
