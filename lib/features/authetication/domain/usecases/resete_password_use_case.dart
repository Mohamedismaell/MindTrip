import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class ResetePasswordUseCase {
  final AuthRepository _repository;

  const ResetePasswordUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<void>> call({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) {
    return _repository.resetPassword(
      email: email,
      resetToken: resetToken,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
  }
}
