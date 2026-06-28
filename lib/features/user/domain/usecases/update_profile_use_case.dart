import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/user/domain/repositories/user_repository.dart';

class UpdateProfileUseCase {
  final UserRepository _repository;

  UpdateProfileUseCase({required UserRepository repository})
    : _repository = repository;

  Future<Result<void>> call({
    String? displayName,
    String? phoneNumber,
    String? bio,
  }) {
    return _repository.updateProfile(
      displayName: displayName,
      phoneNumber: phoneNumber,
      bio: bio,
    );
  }
}
