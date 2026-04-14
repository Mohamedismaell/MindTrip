import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  const LogoutUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<void>> call({required String refreshToken}) {
    return _repository.logout(refreshToken: refreshToken);
  }
}
