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
import 'package:mindtrip/core/shared/auth/token_manager.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:mindtrip/core/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:mindtrip/core/shared/user/data/repositories/user_repository_impl.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/core/shared/auth/secure_token_storage.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_remote_data_source.dart';

CacheHelper get cacheHelper => sl<CacheHelper>();

class CommonDi {
  CommonDi._();

  static Future<void> init() async {
    sl.registerLazySingleton(() => ThemeCubit());
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => InternetConnection());

    //! Core
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<InternetConnection>()),
    );
    sl.registerLazySingleton(() => RetryQueue());
    sl.registerLazySingleton(() => RetryRunner(sl<Dio>(), sl<RetryQueue>()));

    sl.registerLazySingleton(
      () => ApiInterceptor(sl<NetworkInfo>(), sl<RetryQueue>()),
    );
    sl.registerLazySingleton(() => SecureTokenStorage());

    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(api: sl<DioConsumer>()),
    );
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(storage: sl<SecureTokenStorage>()),
    );
    sl.registerLazySingleton(
      () => TokenManager(
        authRemoteDataSource: sl<AuthRemoteDataSource>(),
        authLocalDataSource: sl<AuthLocalDataSource>(),
      ),
    );
    sl.registerLazySingleton(
      () => AuthInterceptor(
        storage: sl<SecureTokenStorage>(),
        dio: sl<Dio>(),
        getTokenManager: () => sl<TokenManager>(),
      ),
    );
    sl.registerLazySingleton(() => LoggingInterceptor());
    sl.registerLazySingleton(
      () => DioConsumer(
        sl<Dio>(),
        sl<ApiInterceptor>(),
        sl<AuthInterceptor>(),
        sl<LoggingInterceptor>(),
      ),
    );

    //! Validators
    // sl.registerLazySingleton(() => FormValidators());
    // sl.registerLazySingleton(() => UserValidation());
    //! Data Sources
    sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource(),
    );
    // sl.registerLazySingleton<UserLocalDataSource>(
    //   () => UserLocalDataSource(newsBox: newsBox),
    // );
    //! Repositories
    sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        remoteDataSource: sl<UserRemoteDataSource>(),
        // localDataSource: sl<UserLocalDataSource>(),
      ),
    );
    //! Use Cases
    sl.registerLazySingleton(
      () => GetCurrentUser(repository: sl<UserRepository>()),
    );
    //! Local Storage
    final cacheHelper = CacheHelper();
    await cacheHelper.init();
    sl.registerSingleton<CacheHelper>(cacheHelper);

    //!Cubits
    sl.registerLazySingleton(
      () => AppConnectionCubit(sl<InternetConnection>(), sl<RetryRunner>()),
    );
    // sl.registerFactory(() => UserCubit(sl<GetCurrentUser>()));
  }
}
