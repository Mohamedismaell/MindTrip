import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/update_user_interests_use_case.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/upload_profile_photo_use_case.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/core/connections/result.dart';

part 'user_state.dart';

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
    emit(state.copyWith(status: UserStatus.loading));

    final result = await _getCurrentUser.call();

    result.when(
      success: (user) =>
          emit(state.copyWith(user: user, status: UserStatus.loaded)),
      failure: (f) =>
          emit(state.copyWith(status: UserStatus.error, message: f.message)),
    );
  }

  void setUser(UserEntity user) {
    emit(state.copyWith(user: user, status: UserStatus.loaded));
  }

  Future<Result<void>> updateUserInterests(List<String> interests) async {
    final result = await _updateUserInterests(interests);
    result.when(
      success: (_) {
        if (state.user != null) {
          final updatedUser = state.user!.copyWith(interests: interests);
          emit(state.copyWith(user: updatedUser));
        }
      },
      failure: (_) {},
    );
    return result;
  }

  /// Uploads a profile photo in the background.
  ///
  /// 1. Immediately shows the local file as an optimistic preview.
  /// 2. Uploads in the background (UI is not blocked).
  /// 3. On success: swaps local preview → CDN URL.
  /// 4. On failure: keeps local preview + sets failed status for retry.
  Future<void> uploadProfilePhoto(String filePath) async {
    // Optimistic: show local image immediately
    emit(state.copyWith(
      photoUploadStatus: PhotoUploadStatus.uploading,
      localPhotoPath: filePath,
    ));

    final result = await _uploadProfilePhoto(filePath);

    result.when(
      success: (url) {
        if (state.user != null) {
          final updated = state.user!.copyWith(profilePhotoUrl: url);
          emit(state.copyWith(
            user: updated,
            photoUploadStatus: PhotoUploadStatus.success,
            clearLocalPath: true,
          ));
        }
      },
      failure: (f) {
        emit(state.copyWith(
          photoUploadStatus: PhotoUploadStatus.failed,
          message: f.message,
        ));
      },
    );
  }

  /// Retries the last failed photo upload using the saved local file path.
  Future<void> retryPhotoUpload() async {
    final path = state.localPhotoPath;
    if (path == null) return;
    await uploadProfilePhoto(path);
  }

  /// Dismisses the photo upload error and resets to idle.
  void dismissPhotoUploadError() {
    emit(state.copyWith(
      photoUploadStatus: PhotoUploadStatus.idle,
      clearLocalPath: true,
    ));
  }

  void clear() {
    emit(const UserState());
  }
}
