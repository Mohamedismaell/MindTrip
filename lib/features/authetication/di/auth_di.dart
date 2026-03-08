import 'package:mindtrip/core/database/api/dio_consumer.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/stoarge/secure_token_storage.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_remote_data_source.dart';
import 'package:mindtrip/features/authetication/data/repositories/auth_repository_impl.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';
import 'package:mindtrip/features/authetication/domain/usecases/get_current_user_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/refresh_token_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_in_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_up_use_case.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';

class AuthDi {
  AuthDi._();

  static void init() {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(api: sl<DioConsumer>()),
    );
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(storage: sl<SecureTokenStorage>()),
    );

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

    sl.registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        signInUseCase: sl<SignInUseCase>(),
        signUpUseCase: sl<SignUpUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
        getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
      ),
    );
  }
}
