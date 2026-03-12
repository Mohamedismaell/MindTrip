import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  const GetCurrentUserUseCase({required AuthRepository repository})
    : _repository = repository;

  // Future<Result<UserEntity>> call() {
  //   return _repository.getCurrentUser();
  // }
}
