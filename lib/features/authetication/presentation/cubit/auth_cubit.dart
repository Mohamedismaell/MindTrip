import 'package:bloc/bloc.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/enums/otp_flow.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/features/authetication/domain/usecases/facebook_auth_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/forget_password_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/googel_auth.dart';
import 'package:mindtrip/features/authetication/domain/usecases/resend_email_otp_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/resete_password_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_in_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_up_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/verify_email_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/verify_password_otp_use_case.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final GoogleAuthProvider _googleAuthProvider;
  final GoogleAuthUseCase _googleAuthUseCase;
  final FacebookAuthProvider _facebookAuthProvider;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final VerifyPsswordOtpUseCase _verifyPasswordOtpUseCase;
  final ResetePasswordUseCase _resetPasswordUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResendEmailOtpUseCase _resendEmailOtpUseCase;
  AuthCubit({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required GoogleAuthProvider googleAuthProvider,
    required GoogleAuthUseCase googleAuthUseCase,
    required FacebookAuthProvider facebookAuthProvider,
    required FacebookAuthUseCase facebookAuthUseCase,
    required ForgetPasswordUseCase forgetPasswordUseCase,
    required VerifyPsswordOtpUseCase verifyPasswordOtpUseCase,
    required ResetePasswordUseCase resetPasswordUseCase,
    required VerifyEmailUseCase verifyEmailUseCase,
    required ResendEmailOtpUseCase resendEmailOtpUseCase,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _googleAuthProvider = googleAuthProvider,
       _googleAuthUseCase = googleAuthUseCase,
       _facebookAuthProvider = facebookAuthProvider,
       _forgetPasswordUseCase = forgetPasswordUseCase,
       _facebookAuthUseCase = facebookAuthUseCase,
       _verifyPasswordOtpUseCase = verifyPasswordOtpUseCase,
       _resetPasswordUseCase = resetPasswordUseCase,
       _verifyEmailUseCase = verifyEmailUseCase,
       _resendEmailOtpUseCase = resendEmailOtpUseCase,
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
      success: (_) {
        emit(
          state.copyWith(
            status: AuthStatus.otpSent,
            otpFlow: OtpFlow.signUp,
            email: email,
          ),
        );
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

      if (idToken == null) {
        emit(state.copyWith(status: AuthStatus.initial));
        return;
      }

      final result = await _googleAuthUseCase(token: idToken);
      if (isClosed) return;

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
    } catch (e) {
      if (isClosed) return;

      final failure = ApiErrorMapper.fromException(e);

      if (failure is CancelledFailure) {
        emit(state.copyWith(status: AuthStatus.initial));
        return;
      }

      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: failure.message,
        ),
      );
    }
  }

  Future<void> loginWithFacebook() async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final accessToken = await _facebookAuthProvider.signIn();
      if (isClosed) return;

      if (accessToken == null) {
        emit(state.copyWith(status: AuthStatus.initial));
        return;
      }

      final result = await _facebookAuthUseCase(token: accessToken);
      if (isClosed) return;

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
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _forgetPasswordUseCase(email: email);

    result.when(
      success: (_) {
        emit(
          state.copyWith(
            status: AuthStatus.otpSent,
            otpFlow: OtpFlow.forgetPassword,
            email: email,
          ),
        );
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

  Future<void> verifyPasswordOtp({
    required String email,
    required String otp,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _verifyPasswordOtpUseCase(email: email, otp: otp);

    result.when(
      success: (verifyPassowrdOtp) {
        emit(
          state.copyWith(
            status: AuthStatus.otpVerified,
            resetToken: verifyPassowrdOtp.resetToken,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: AuthStatus.otpFailure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _resetPasswordUseCase(
      email: email,
      resetToken: resetToken,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );

    result.when(
      success: (_) {
        emit(state.copyWith(status: AuthStatus.passwordResetSuccess));
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

  Future<void> verifyEmail({required String email, required String otp}) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _verifyEmailUseCase(email: email, otp: otp);

    result.when(
      success: (_) {
        emit(state.copyWith(status: AuthStatus.otpVerified));
      },
      failure: (error) {
        emit(
          state.copyWith(
            status: AuthStatus.otpFailure,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> resendOtp() async {
    final email = state.email;
    if (email == null) return;

    emit(state.copyWith(status: AuthStatus.initial, errorMessage: null));

    final result = await _resendEmailOtpUseCase(email: email);

    result.when(
      success: (_) {
        emit(state.copyWith(status: AuthStatus.otpSent));
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
}
