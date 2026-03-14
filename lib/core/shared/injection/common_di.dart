import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mindtrip/core/connections/network_info.dart';
import 'package:mindtrip/core/connections/retry_queue.dart';
import 'package:mindtrip/core/connections/retry_runner.dart';
import 'package:mindtrip/core/database/api/interceptors/api_interceptor.dart';
import 'package:mindtrip/core/database/api/dio_consumer.dart';
import 'package:mindtrip/core/database/api/interceptors/auth_interceptor.dart';
import 'package:mindtrip/core/database/api/interceptors/logging_interceptor.dart';
import 'package:mindtrip/core/database/cache/cache_helper.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/token_manager.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_router.dart';
import 'package:mindtrip/core/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:mindtrip/core/shared/user/data/repositories/user_repository_impl.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/core/shared/auth/secure_token_storage.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_remote_data_source.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';

CacheHelper get cacheHelper => sl<CacheHelper>();

class CommonDi {
  CommonDi._();

  static Future<void> init() async {
    //  Infrastructure
    sl.registerLazySingleton(() => ThemeCubit());
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => InternetConnection());

    // Core — Network
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<InternetConnection>()),
    );
    sl.registerLazySingleton(() => RetryQueue());
    sl.registerLazySingleton(() => RetryRunner(sl<Dio>(), sl<RetryQueue>()));

    sl.registerLazySingleton(
      () => ApiInterceptor(sl<NetworkInfo>(), sl<RetryQueue>()),
    );

    // Core — Security / Tokens
    sl.registerLazySingleton(() => SecureTokenStorage());

    // Core — HTTP (DioConsumer MUST be registered before any DataSource that needs it)
    sl.registerLazySingleton(() => LoggingInterceptor());

    // AuthLocalDataSource needs to exist before AuthInterceptor/TokenManager
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(storage: sl<SecureTokenStorage>()),
    );

    // DioConsumer depends on interceptors — register interceptors first, then DioConsumer
    // AuthInterceptor depends on TokenManager, but TokenManager depends on AuthRemoteDataSource
    // which depends on DioConsumer. Break the cycle with a lazy getter for TokenManager.
    sl.registerLazySingleton(
      () => AuthInterceptor(
        storage: sl<SecureTokenStorage>(),
        dio: sl<Dio>(),
        getTokenManager: () => sl<TokenManager>(),
      ),
    );
    sl.registerLazySingleton(
      () => DioConsumer(
        sl<Dio>(),
        sl<ApiInterceptor>(),
        sl<AuthInterceptor>(),
        sl<LoggingInterceptor>(),
      ),
    );

    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(api: sl<DioConsumer>()),
    );

    sl.registerLazySingleton(
      () => TokenManager(
        authRemoteDataSource: sl<AuthRemoteDataSource>(),
        authLocalDataSource: sl<AuthLocalDataSource>(),
      ),
    );

    //  User
    sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource(),
    );
    sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl<UserRemoteDataSource>()),
    );
    sl.registerLazySingleton(
      () => GetCurrentUser(repository: sl<UserRepository>()),
    );

    //  Local Storage
    final cacheHelper = CacheHelper();
    await cacheHelper.init();
    sl.registerSingleton<CacheHelper>(cacheHelper);

    //  App-Level Cubits
    sl.registerLazySingleton(
      () => AppConnectionCubit(sl<InternetConnection>(), sl<RetryRunner>()),
    );

    sl.registerLazySingleton(() => GoogleAuthProvider());
    sl.registerLazySingleton(() => FacebookAuthProvider());

    sl.registerLazySingleton(
      () => AppGateCubit(
        onboardingRepository: sl<OnboardingRepository>(),
        logoutUseCase: sl<LogoutUseCase>(),
        authLocal: sl<AuthLocalDataSource>(),
        googleAuthProvider: sl<GoogleAuthProvider>(),
        facebookAuthProvider: sl<FacebookAuthProvider>(),
      ),
    );

    sl.registerLazySingleton(() => AppRouter(appGateCubit: sl<AppGateCubit>()));
  }
}
