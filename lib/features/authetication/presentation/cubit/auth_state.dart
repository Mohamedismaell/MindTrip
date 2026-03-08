part of 'auth_cubit.dart';

/// ──────────────
/// [PRESENTATION LAYER] — State
///
/// [AuthState] is **immutable** (all fields are `final`) and uses [Equatable]
/// so Bloc only rebuilds widgets when a meaningful property changes.
///
/// Key design decisions:
///   • [AuthStatus] enum drives loading / success / failure transitions.
///   • [user] is populated only after a successful sign-in / sign-up / auto-login.
///   • [errorMessage] is nullable — `null` means "no error".
///   • UI-only flags (obscurePassword, rememberMe) live here too so the cubit
///     can drive them without the widgets holding mutable state.
///   • [copyWith] ensures immutability — new state is always a fresh object.
/// ──────────────
class AuthState extends Equatable {
  /// Current auth flow status.
  final AuthStatus status;

  /// The authenticated user — only non-null after a successful auth action.
  final UserEntity? user;

  /// Human-readable error message to display in UI (snackbar, dialog, etc.).
  final String? errorMessage;

  //  UI helpers

  /// Whether the password field text is hidden.
  final bool obscurePassword;

  /// Whether the confirm-password field text is hidden.
  final bool obscureConfirm;

  /// Whether "Remember Me" is checked.
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
