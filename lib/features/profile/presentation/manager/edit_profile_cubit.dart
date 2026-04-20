import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/update_profile_use_case.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/upload_profile_photo_use_case.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UploadProfilePhotoUseCase _uploadProfilePhoto;
  final UpdateProfileUseCase _updateProfile;
  final UserCubit _userCubit;

  EditProfileCubit({
    required UploadProfilePhotoUseCase uploadProfilePhoto,
    required UpdateProfileUseCase updateProfile,
    required UserCubit userCubit,
  }) : _uploadProfilePhoto = uploadProfilePhoto,
       _updateProfile = updateProfile,
       _userCubit = userCubit,
       super(const EditProfileState());

  void init(UserEntity user) {
    emit(
      state.copyWith(
        originalUser: user,
        draftDisplayName: user.displayName,
        draftPhoneNumber: user.phoneNumber ?? '',
      ),
    );
  }

  void pickPhoto(String filePath) {
    emit(state.copyWith(pendingPhotoPath: filePath));
  }

  void updateDisplayName(String value) {
    emit(state.copyWith(draftDisplayName: value));
  }

  void updatePhoneNumber(String value) {
    emit(state.copyWith(draftPhoneNumber: value));
  }

  Future<void> saveChanges() async {
    if (!state.hasChanges) return;

    emit(state.copyWith(saveStatus: EditSaveStatus.saving));

    String? newPhotoUrl;

    // Step 1
    if (state.pendingPhotoPath != null) {
      final photoResult = await _uploadProfilePhoto(state.pendingPhotoPath!);

      final failed = photoResult.when(
        success: (url) {
          newPhotoUrl = url;
          return false;
        },
        failure: (f) {
          emit(
            state.copyWith(
              saveStatus: EditSaveStatus.failed,
              errorMessage: f.message,
            ),
          );
          return true;
        },
      );

      if (failed) return;
    }

    // Step 2
    final nameChanged =
        state.draftDisplayName != state.originalUser?.displayName;
    final phoneChanged =
        state.draftPhoneNumber != (state.originalUser?.phoneNumber ?? '');

    if (nameChanged || phoneChanged) {
      final profileResult = await _updateProfile(
        displayName: nameChanged ? state.draftDisplayName : null,
        phoneNumber: phoneChanged ? state.draftPhoneNumber : null,
      );

      final failed = profileResult.when(
        success: (_) => false,
        failure: (f) {
          emit(
            state.copyWith(
              saveStatus: EditSaveStatus.failed,
              errorMessage: f.message,
            ),
          );
          return true;
        },
      );

      if (failed) return;
    }

    // Step 3
    if (state.originalUser != null) {
      final updated = state.originalUser!.copyWith(
        displayName: state.draftDisplayName,
        phoneNumber: state.draftPhoneNumber,
        profilePhotoUrl: newPhotoUrl ?? state.originalUser!.profilePhotoUrl,
      );
      _userCubit.setUser(updated);
    }

    emit(
      state.copyWith(
        saveStatus: EditSaveStatus.success,
        clearPendingPhoto: true,
      ),
    );
  }

  // reset and clean
  void dismissError() {
    emit(state.copyWith(saveStatus: EditSaveStatus.idle, clearError: true));
  }
}
