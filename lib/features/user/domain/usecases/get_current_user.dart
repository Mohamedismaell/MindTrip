import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/user/domain/repositories/user_repository.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

class GetCurrentUser {
  final UserRepository _repository;

  GetCurrentUser({required UserRepository repository})
    : _repository = repository;

  Future<Result<UserEntity>> call() {
    return _repository.getCurrentUser();
  }
}
