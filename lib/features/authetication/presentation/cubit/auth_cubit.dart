import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/usecases/get_current_user_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_in_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_up_use_case.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  // final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthCubit({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       //  _getCurrentUserUseCase = getCurrentUserUseCase,
       super(const AuthState());

  void togglePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPassword() {
    emit(state.copyWith(obscureConfirm: !state.obscureConfirm));
  }

  void toggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  Future<void> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _signInUseCase(
      email: email,
      password: password,
      rememberMe: rememberMe,
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

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _signUpUseCase(
      name: name,
      email: email,
      password: password,
      rememberMe: rememberMe,
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
