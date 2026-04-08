import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class VerifyEmailUseCase {
  final AuthRepository _repository;

  const VerifyEmailUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<void>> call({required String email, required String otp}) {
    return _repository.verifyEmail(email: email, otp: otp);
  }
}
