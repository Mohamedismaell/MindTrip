import 'package:mindtrip/features/authetication/data/models/verify_passowrd_otp.dart';
import 'package:mindtrip/features/authetication/domain/entities/verify_password_otp_entity.dart';

extension VerifyPasswordOtpMapper on VerifyPassowrdOtp {
  VerifyPasswordOtpEntity toEntity() {
    return VerifyPasswordOtpEntity(resetToken: resetToken);
  }
}

extension VerifyPasswordOtpEntityMapper on VerifyPasswordOtpEntity {
  VerifyPassowrdOtp toModel() {
    return VerifyPassowrdOtp(resetToken: resetToken, message: '');
  }
}
