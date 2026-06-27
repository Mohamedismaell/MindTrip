import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/cache/cache_helper.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:mindtrip/features/profile/domain/use_cases/get_my_reviews_use_case.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_cubit.dart';
import 'package:mindtrip/features/user/domain/usecases/update_profile_use_case.dart';
import 'package:mindtrip/features/user/domain/usecases/upload_profile_photo_use_case.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/features/profile/domain/repositories/profile_repository.dart';
import 'package:mindtrip/features/profile/domain/use_cases/delete_account.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_cubit.dart';

import '../data/datasources/profile_remote_datasource.dart';
import '../data/repositories/profile_repository_impl.dart';

class ProfileDi {
  ProfileDi._();

  static void init() {
    // Data sources
    sl.registerLazySingleton<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasource(apiConsumer: sl<ApiConsumer>()),
    );
    sl.registerLazySingleton<ProfileLocalDatasource>(
      () => ProfileLocalDatasourceImpl(cacheHelper: sl<CacheHelper>()),
    );

    // Repositories
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteDatasource: sl<ProfileRemoteDatasource>(),
        localDatasource: sl<ProfileLocalDatasource>(),
      ),
    );
    sl.registerLazySingleton<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(repository: sl<ProfileRepository>()),
    );
    sl.registerLazySingleton<GetMyReviewsUseCase>(
      () => GetMyReviewsUseCase(repository: sl<ProfileRepository>()),
    );

    // Cubits
    sl.registerFactory(
      () => EditProfileCubit(
        uploadProfilePhoto: sl<UploadProfilePhotoUseCase>(),
        updateProfile: sl<UpdateProfileUseCase>(),
        userCubit: sl<UserCubit>(),
        deleteAccountUseCase: sl<DeleteAccountUseCase>(),
      ),
    );
    sl.registerFactory(
      () => ProfileReviewsCubit(getMyReviewsUseCase: sl<GetMyReviewsUseCase>()),
    );
  }
}
