import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool obscurePassword = true;
  bool obscureConfirm = true;

  void togglePassword() {
    obscurePassword = !obscurePassword;
    emit(AuthUiUpdated());
  }

  void toggleConfirmPassword() {
    obscureConfirm = !obscureConfirm;
    emit(AuthUiUpdated());
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure("Something went wrong"));
    }
  }
}
