import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';

class UploadProfilePhotoUseCase {
  final UserRepository _repository;

  UploadProfilePhotoUseCase({required UserRepository repository})
    : _repository = repository;

  Future<Result<String>> call(String filePath) {
    return _repository.uploadProfilePhoto(filePath);
  }
}
