import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class FacebookAuthUseCase {
  final AuthRepository _repository;

  const FacebookAuthUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<UserEntity>> call({required String token}) {
    return _repository.facebookAuth(token: token);
  }
}
