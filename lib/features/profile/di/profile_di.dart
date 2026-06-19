import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
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

    // Repositories
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(datasource: sl<ProfileRemoteDatasource>()),
    );
    sl.registerLazySingleton<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(repository: sl<ProfileRepository>()),
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
  }
}
