part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool obscurePassword;
  final bool obscureConfirm;
  final bool rememberMe;
  final AuthStatus status;
  final String? errorMessage;

  const AuthState({
    this.obscurePassword = true,
    this.obscureConfirm = true,
    this.rememberMe = false,
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? obscurePassword,
    bool? obscureConfirm,
    bool? rememberMe,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirm: obscureConfirm ?? this.obscureConfirm,
      rememberMe: rememberMe ?? this.rememberMe,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    obscurePassword,
    obscureConfirm,
    rememberMe,
    status,
    errorMessage,
  ];
}
