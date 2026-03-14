import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/usecases/facebook_auth_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/googel_auth.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_in_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_up_use_case.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final GoogleAuthProvider _googleAuthProvider;
  final GoogleAuthUseCase _googleAuthUseCase;
  final FacebookAuthProvider _facebookAuthProvider;

  final FacebookAuthUseCase _facebookAuthUseCase;
  AuthCubit({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required GoogleAuthProvider googleAuthProvider,
    required GoogleAuthUseCase googleAuthUseCase,
    required FacebookAuthProvider facebookAuthProvider,
    required FacebookAuthUseCase facebookAuthUseCase,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _googleAuthProvider = googleAuthProvider,
       _googleAuthUseCase = googleAuthUseCase,
       _facebookAuthProvider = facebookAuthProvider,
       _facebookAuthUseCase = facebookAuthUseCase,
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

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final idToken = await _googleAuthProvider.signIn();
      if (isClosed) return;

      print('Id token google here**********$idToken');
      if (idToken == null) {
        emit(state.copyWith(status: AuthStatus.initial));
        return;
      }

      await _googleAuthUseCase(token: idToken);
      if (isClosed) return;
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      if (isClosed) return;
      print('Error google here**********$e');
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }

  Future<void> loginWithFacebook() async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final accessToken = await _facebookAuthProvider.signIn();
      if (isClosed) return;

      print('Access token Facebook here**********$accessToken');
      if (accessToken == null) {
        emit(state.copyWith(status: AuthStatus.initial));
        return;
      }

      await _facebookAuthUseCase(token: accessToken);
      if (isClosed) return;
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      if (isClosed) return;
      print('Error Facebook here**********$e');
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }

  // Future<void> checkAutoLogin() async {
  //   emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

  //   final result = await _GoogleAuthProvider();

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
