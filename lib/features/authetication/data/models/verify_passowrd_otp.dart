import 'package:mindtrip/features/authetication/domain/entities/verify_password_otp_entity.dart';

class VerifyPassowrdOtp {
  final String resetToken;
  final String message;

  VerifyPassowrdOtp({required this.resetToken, required this.message});

  factory VerifyPassowrdOtp.fromJson(Map<String, dynamic> json) {
    return VerifyPassowrdOtp(
      resetToken: json['resetToken'],
      message: json['message'],
    );
  }
  VerifyPasswordOtpEntity toEntity() {
    return VerifyPasswordOtpEntity(resetToken: resetToken);
  }
}
