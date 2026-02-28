import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/auth_status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  void togglePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPassword() {
    emit(state.copyWith(obscureConfirm: !state.obscureConfirm));
  }

  void toggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: "Something went wrong",
        ),
      );
    }
  }
}
