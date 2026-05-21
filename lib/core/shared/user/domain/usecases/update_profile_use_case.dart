import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';

class UpdateProfileUseCase {
  final UserRepository _repository;

  UpdateProfileUseCase({required UserRepository repository})
    : _repository = repository;

  Future<Result<void>> call({String? displayName, String? phoneNumber}) {
    return _repository.updateProfile(
      displayName: displayName,
      phoneNumber: phoneNumber,
    );
  }
}
