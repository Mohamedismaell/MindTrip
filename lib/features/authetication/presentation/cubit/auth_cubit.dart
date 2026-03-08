import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/usecases/get_current_user_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_in_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_up_use_case.dart';

part 'auth_state.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [PRESENTATION LAYER] — Cubit
///
/// [AuthCubit] orchestrates the authentication UI flow. It does **not** contain
/// any data-layer or network logic — all work is delegated to use-cases.
///
/// Responsibilities:
///   • Drive state transitions (loading → success / failure).
///   • Toggle UI helpers (password visibility, remember-me).
///   • Invoke use-cases and map [Result] outcomes to [AuthState].
///
/// This cubit is provided via BlocProvider at the route level or globally.
/// ──────────────────────────────────────────────────────────────────────────────
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthCubit({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _logoutUseCase = logoutUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(const AuthState());

  // ──────────────── UI Helpers ────────────────

  /// Toggle password field obscure state.
  void togglePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  /// Toggle confirm-password field obscure state.
  void toggleConfirmPassword() {
    emit(state.copyWith(obscureConfirm: !state.obscureConfirm));
  }

  /// Toggle "Remember Me" checkbox.
  void toggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  // ──────────────── Auth Actions ────────────────

  /// Sign in with [email] and [password].
  ///
  /// Emits [AuthStatus.loading] → then either [AuthStatus.success] or
  /// [AuthStatus.failure] depending on the use-case result.
  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _signInUseCase(email: email, password: password);

    result.when(
      success: (user) {
        emit(state.copyWith(status: AuthStatus.success, user: user));
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  /// Register a new account with [name], [email], and [password].
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    // required String confirmPassword,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _signUpUseCase(
      name: name,
      email: email,
      password: password,
    );

    result.when(
      success: (user) {
        emit(state.copyWith(status: AuthStatus.success, user: user));
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  /// Log the user out — clears tokens and resets state.
  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _logoutUseCase();

    result.when(
      success: (_) {
        emit(const AuthState()); // Reset to initial state.
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  /// Auto-login: try to restore the session from stored tokens.
  ///
  /// Called once at app startup. If tokens exist and are valid, transitions
  /// to [AuthStatus.success]. Otherwise stays [AuthStatus.initial] silently.
  // Future<void> checkAutoLogin() async {
  //   emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

  //   final result = await _getCurrentUserUseCase();

  //   result.when(
  //     success: (user) {
  //       emit(state.copyWith(status: AuthStatus.success, user: user));
  //     },
  //     failure: (_) {
  //       // No valid session — remain on the login screen.
  //       emit(state.copyWith(status: AuthStatus.initial));
  //     },
  //   );
  // }
}
