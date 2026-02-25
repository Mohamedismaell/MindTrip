import 'package:ttproj/core/connections/network_info.dart';
import 'package:ttproj/core/connections/retry_queue.dart';
import 'package:ttproj/core/connections/retry_runner.dart';
import 'package:ttproj/core/database/api/api_interceptor.dart';
import 'package:ttproj/core/database/api/dio_consumer.dart';
import 'package:ttproj/core/database/cache/cache_helper.dart';
import 'package:ttproj/core/shared/injection/service_locator.dart';
import 'package:ttproj/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:ttproj/core/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:ttproj/core/shared/user/data/repositories/user_repository_impl.dart';
import 'package:ttproj/core/shared/user/domain/repositories/user_repository.dart';
import 'package:ttproj/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:ttproj/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:ttproj/core/theme/cubit/theme_cubit.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ttproj/core/database/cache/cache_helper.dart';

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
    sl.registerLazySingleton(
      () => DioConsumer(sl<Dio>(), sl<ApiInterceptor>()),
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
