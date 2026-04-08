import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/verify_password_otp_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class VerifyPsswordOtpUseCase {
  final AuthRepository _repository;

  const VerifyPsswordOtpUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<VerifyPasswordOtpEntity>> call({
    required String email,
    required String otp,
  }) {
    return _repository.verifyPasswordOtp(email: email, otp: otp);
  }
}
