import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  const LogoutUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<void>> call() {
    return _repository.logout();
  }
}
