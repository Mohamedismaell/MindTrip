class LoginParams {
  final String? email;
  final String? password;

  LoginParams({required this.email, required this.password});
}

class SignupParams {
  final String? name;
  final String? email;
  final String? password;

  SignupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

class ForgotPasswordParams {
  final String email;

  ForgotPasswordParams({required this.email});
}

class OTPParams {
  final String? code;

  OTPParams({required this.code});
}
