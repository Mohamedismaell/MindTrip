part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;

  //  UI helpers
  final bool obscurePassword;
  final bool obscureConfirm;
  final bool rememberMe;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.obscurePassword = true,
    this.obscureConfirm = true,
    this.rememberMe = false,
  });

  //  copyWith

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
    bool? obscurePassword,
    bool? obscureConfirm,
    bool? rememberMe,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirm: obscureConfirm ?? this.obscureConfirm,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  //  Equatable

  @override
  List<Object?> get props => [
    status,
    user,
    errorMessage,
    obscurePassword,
    obscureConfirm,
    rememberMe,
  ];
}
