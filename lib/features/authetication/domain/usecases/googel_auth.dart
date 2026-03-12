import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class GoogleAuthUseCase {
  final AuthRepository _repository;

  const GoogleAuthUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<UserEntity>> call({required String token}) {
    return _repository.googleAuth(token: token);
  }
}
