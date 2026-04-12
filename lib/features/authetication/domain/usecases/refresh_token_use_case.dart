import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository _repository;

  const RefreshTokenUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<UserEntity>> call() {
    return _repository.refreshToken();
  }
}
