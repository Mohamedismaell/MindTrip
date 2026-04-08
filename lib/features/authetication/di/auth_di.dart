import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_remote_data_source.dart';
import 'package:mindtrip/features/authetication/data/repositories/auth_repository_impl.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';
import 'package:mindtrip/features/authetication/domain/usecases/facebook_auth_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/forget_password_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/get_current_user_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/googel_auth.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/refresh_token_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/resete_password_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_in_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_up_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/verify_password_otp_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/verify_email_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/resend_email_otp_use_case.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';

class AuthDi {
  AuthDi._();

  static void init() {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        localDataSource: sl<AuthLocalDataSource>(),
      ),
    );
    sl.registerLazySingleton(
      () => SignInUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => SignUpUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => LogoutUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => RefreshTokenUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => GetCurrentUserUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => GoogleAuthUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => FacebookAuthUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => ForgetPasswordUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => VerifyPsswordOtpUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => VerifyEmailUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => ResendEmailOtpUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => ResetePasswordUseCase(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        signInUseCase: sl<SignInUseCase>(),
        signUpUseCase: sl<SignUpUseCase>(),
        googleAuthProvider: sl<GoogleAuthProvider>(),
        googleAuthUseCase: sl<GoogleAuthUseCase>(),
        facebookAuthProvider: sl<FacebookAuthProvider>(),
        facebookAuthUseCase: sl<FacebookAuthUseCase>(),
        forgetPasswordUseCase: sl<ForgetPasswordUseCase>(),
        verifyPasswordOtpUseCase: sl<VerifyPsswordOtpUseCase>(),
        resetPasswordUseCase: sl<ResetePasswordUseCase>(),
        verifyEmailUseCase: sl<VerifyEmailUseCase>(),
        resendEmailOtpUseCase: sl<ResendEmailOtpUseCase>(),
      ),
    );
  }
}
