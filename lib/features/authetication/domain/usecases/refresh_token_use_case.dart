import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository _repository;

  const RefreshTokenUseCase({required AuthRepository repository})
    : _repository = repository;

  //   Future<Result<AuthTokens>> call() {
  //     return _repository.refreshToken();
  //   }
}
