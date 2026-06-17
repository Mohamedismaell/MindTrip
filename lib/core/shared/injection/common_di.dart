import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mindtrip/core/connections/network_info.dart';
import 'package:mindtrip/core/connections/retry_queue.dart';
import 'package:mindtrip/core/connections/retry_runner.dart';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/dio_consumer.dart';
import 'package:mindtrip/core/database/api/interceptors/api_interceptor.dart';
import 'package:mindtrip/core/database/api/interceptors/auth_interceptor.dart';
import 'package:mindtrip/core/database/api/interceptors/logging_interceptor.dart';
import 'package:mindtrip/core/database/api/interceptors/retry_interceptor.dart';
import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/core/database/cache/cache_helper.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/secure_token_storage.dart';
import 'package:mindtrip/core/shared/auth/token_manager.dart';
import 'package:mindtrip/core/shared/data/datasources/favorites_local_data_source.dart';
import 'package:mindtrip/core/shared/data/datasources/favorites_remote_data_source.dart';
import 'package:mindtrip/core/shared/data/datasources/places_local_data_source.dart';
import 'package:mindtrip/core/shared/data/repositories/favorites_repository_impl.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';
import 'package:mindtrip/core/shared/domain/usecases/get_favorite_places_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/get_favorites_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/sync_favorites_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/toggle_favorite_use_case.dart';
import 'package:mindtrip/core/shared/favorite/cubit/favorite_cubit.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/connection_cubit/connection_bloc.dart';
import 'package:mindtrip/core/shared/routes/app_router.dart';
import 'package:mindtrip/core/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:mindtrip/core/shared/user/data/repositories/user_repository_impl.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/update_profile_use_case.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/update_user_interests_use_case.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/upload_profile_photo_use_case.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/core/utils/image_pick_crop_service.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_remote_data_source.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/favorite/cubit/saved_places_cubit.dart';
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

    sl.registerLazySingleton(
      () => AuthInterceptor(
        storage: sl<SecureTokenStorage>(),
        dio: sl<Dio>(),
        getTokenManager: () => sl<TokenManager>(),
        onLogout: () => sl<AppGateCubit>().logout(),
      ),
    );
    sl.registerLazySingleton(
      () => RetryInterceptor(dio: sl<Dio>(), retryQueue: sl<RetryQueue>()),
    );
    sl.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(
        sl<Dio>(),
        sl<ApiInterceptor>(),
        sl<AuthInterceptor>(),
        sl<RetryInterceptor>(),
        sl<LoggingInterceptor>(),
      ),
    );

    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(api: sl<ApiConsumer>()),
    );

    sl.registerLazySingleton(
      () => TokenManager(
        authRemoteDataSource: sl<AuthRemoteDataSource>(),
        authLocalDataSource: sl<AuthLocalDataSource>(),
      ),
    );

    //  User
    sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource(api: sl<ApiConsumer>()),
    );
    sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl<UserRemoteDataSource>()),
    );
    sl.registerLazySingleton(
      () => GetCurrentUser(repository: sl<UserRepository>()),
    );
    sl.registerLazySingleton(
      () => UpdateUserInterestsUseCase(sl<UserRepository>()),
    );
    sl.registerLazySingleton(
      () => UploadProfilePhotoUseCase(repository: sl<UserRepository>()),
    );
    sl.registerLazySingleton(() => ImagePickCropService());
    sl.registerLazySingleton(
      () => UserCubit(
        getCurrentUser: sl<GetCurrentUser>(),
        updateUserInterests: sl<UpdateUserInterestsUseCase>(),
        uploadProfilePhoto: sl<UploadProfilePhotoUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => UpdateProfileUseCase(repository: sl<UserRepository>()),
    );

    // Favorites
    sl.registerLazySingleton<FavoritesLocalDataSource>(
      () => FavoritesLocalDataSourceImpl(
        box: AppHive.favoritesBox,
        syncQueueBox: AppHive.favoritesSyncQueueBox,
      ),
    );
    sl.registerLazySingleton<PlacesLocalDataSource>(
      () => PlacesLocalDataSourceImpl(),
    );
    sl.registerLazySingleton<FavoritesRemoteDataSource>(
      () => FavoritesRemoteDataSource(api: sl<ApiConsumer>()),
    );
    sl.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(
        local: sl<FavoritesLocalDataSource>(),
        remote: sl<FavoritesRemoteDataSource>(),
        placesLocal: sl<PlacesLocalDataSource>(),
      ),
    );
    sl.registerLazySingleton(
      () => GetFavoritesUseCase(repository: sl<FavoritesRepository>()),
    );
    sl.registerLazySingleton(
      () => ToggleFavoriteUseCase(repository: sl<FavoritesRepository>()),
    );
    sl.registerLazySingleton(
      () => SyncFavoritesUseCase(repository: sl<FavoritesRepository>()),
    );
    sl.registerLazySingleton(
      () => FavoriteCubit(
        getFavoritesUseCase: sl<GetFavoritesUseCase>(),
        toggleFavoriteUseCase: sl<ToggleFavoriteUseCase>(),
        syncFavoritesUseCase: sl<SyncFavoritesUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => GetFavoritePlacesUseCase(repository: sl<FavoritesRepository>()),
    );
    // Factory — a fresh instance per FavoritesScreen entry.
    sl.registerFactory(
      () => SavedPlacesCubit(
        getFavoritePlacesUseCase: sl<GetFavoritePlacesUseCase>(),
        favoriteCubit: sl<FavoriteCubit>(),
      ),
    );

    //  Local Storage
    final cacheHelper = CacheHelper();
    await cacheHelper.init();
    sl.registerSingleton<CacheHelper>(cacheHelper);

    //  App-Level Cubits
    sl.registerLazySingleton(
      () => AppConnectionBloc(sl<InternetConnection>(), sl<RetryRunner>()),
    );

    sl.registerLazySingleton(() => GoogleAuthProvider());
    sl.registerLazySingleton(() => FacebookAuthProvider());

    sl.registerLazySingleton(
      () => AppGateCubit(
        onboardingRepository: sl<OnboardingRepository>(),
        logoutUseCase: sl<LogoutUseCase>(),
        authLocal: sl<AuthLocalDataSource>(),
        tokenManager: sl<TokenManager>(),
        googleAuthProvider: sl<GoogleAuthProvider>(),
        facebookAuthProvider: sl<FacebookAuthProvider>(),
        userCubit: sl<UserCubit>(),
        favoriteCubit: sl<FavoriteCubit>(),
        favoritesRepository: sl<FavoritesRepository>(),
      ),
    );

    sl.registerLazySingleton(() => AppRouter(appGateCubit: sl<AppGateCubit>()));
  }
}
