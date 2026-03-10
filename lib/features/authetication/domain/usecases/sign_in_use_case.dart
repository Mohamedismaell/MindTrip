import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repository;

  const SignInUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<UserEntity>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    return _repository.signIn(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
