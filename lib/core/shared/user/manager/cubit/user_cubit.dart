import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/update_user_interests_use_case.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/upload_profile_photo_use_case.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

part 'user_state.dart';

//Todo: Check if it need Cancel Token.
class UserCubit extends Cubit<UserState> {
  final GetCurrentUser _getCurrentUser;
  final UpdateUserInterestsUseCase _updateUserInterests;
  final UploadProfilePhotoUseCase _uploadProfilePhoto;

  UserCubit({
    required GetCurrentUser getCurrentUser,
    required UpdateUserInterestsUseCase updateUserInterests,
    required UploadProfilePhotoUseCase uploadProfilePhoto,
  }) : _getCurrentUser = getCurrentUser,
       _updateUserInterests = updateUserInterests,
       _uploadProfilePhoto = uploadProfilePhoto,
       super(const UserState());

  Future<void> loadUser() async {
    emit(state.copyWith(userStatus: UserStatus.loading));

    final result = await _getCurrentUser.call();

    result.when(
      success: (user) => emit(
        state.copyWith(
          user: user,
          interests: user.interests,
          userStatus: UserStatus.loaded,
        ),
      ),
      failure: (f) => emit(
        state.copyWith(
          userStatus: UserStatus.error,
          userErrorMessage: f.message,
        ),
      ),
    );
  }

  void setUser(UserEntity user) {
    emit(state.copyWith(user: user, userStatus: UserStatus.loaded));
  }

  void editSelectedCategory(String category) {
    final currentSelected = List<String>.from(state.interests ?? []);

    if (currentSelected.contains(category)) {
      currentSelected.remove(category);
    } else {
      currentSelected.add(category);
    }
    emit(state.copyWith(interests: currentSelected));
  }

  Future<void> updateUserInterests() async {
    emit(state.copyWith(interestStatus: InterestStatus.saving));

    final result = await _updateUserInterests(state.interests!);
    result.when(
      success: (_) {
        if (state.user != null) {
          final updatedUser = state.user!.copyWith(interests: state.interests);
          emit(
            state.copyWith(
              user: updatedUser,
              interestStatus: InterestStatus.saved,
            ),
          );
        }
      },
      failure: (f) {
        emit(
          state.copyWith(
            interestStatus: InterestStatus.failed,
            interestErrorMessage: f.message,
          ),
        );
      },
    );
  }

  Future<void> uploadProfilePhoto(String filePath) async {
    emit(
      state.copyWith(
        photoUploadStatus: PhotoUploadStatus.uploading,
        localPhotoPath: filePath,
      ),
    );

    final result = await _uploadProfilePhoto(filePath);

    result.when(
      success: (url) {
        if (state.user != null) {
          final updated = state.user!.copyWith(profilePhotoUrl: url);
          emit(
            state.copyWith(
              user: updated,
              photoUploadStatus: PhotoUploadStatus.success,
              clearLocalPath: true,
            ),
          );
        }
      },
      failure: (f) {
        emit(
          state.copyWith(
            photoUploadStatus: PhotoUploadStatus.failed,
            photoUploadErrorMessage: f.message,
          ),
        );
      },
    );
  }

  // Future<void> retryPhotoUpload() async {
  //   final path = state.localPhotoPath;
  //   if (path == null) return;
  //   await uploadProfilePhoto(path);
  // }

  // void dismissPhotoUploadError() {
  //   emit(
  //     state.copyWith(
  //       photoUploadStatus: PhotoUploadStatus.idle,
  //       clearLocalPath: true,
  //     ),
  //   );
  // }
  void dismissInterestError() {
    if (!isClosed) {
      emit(state.copyWith(interestStatus: InterestStatus.idle));
    }
  }

  void clear() {
    emit(const UserState());
  }
}
