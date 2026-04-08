import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;

  const VerifyOtpUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<String>> call({required String email, required String otp}) {
    return _repository.verifyOtp(email: email, otp: otp);
  }
}
