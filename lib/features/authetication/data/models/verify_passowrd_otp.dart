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
}
