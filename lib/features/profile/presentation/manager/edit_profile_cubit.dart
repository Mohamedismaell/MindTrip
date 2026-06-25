import 'package:dio/dio.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/user/domain/usecases/update_profile_use_case.dart';
import 'package:mindtrip/features/user/domain/usecases/upload_profile_photo_use_case.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/profile/domain/use_cases/delete_account.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_state.dart';

class EditProfileCubit extends SafeCubit<EditProfileState> {
  final UploadProfilePhotoUseCase _uploadProfilePhoto;
  final UpdateProfileUseCase _updateProfile;
  final UserCubit _userCubit;
  final DeleteAccountUseCase _deleteAccountUseCase;
  EditProfileCubit({
    required UploadProfilePhotoUseCase uploadProfilePhoto,
    required UpdateProfileUseCase updateProfile,
    required UserCubit userCubit,
    required DeleteAccountUseCase deleteAccountUseCase,
  }) : _uploadProfilePhoto = uploadProfilePhoto,
       _updateProfile = updateProfile,
       _userCubit = userCubit,
       _deleteAccountUseCase = deleteAccountUseCase,
       super(const EditProfileState());

  CancelToken? _editCancelToken;
  CancelToken _getEditToken() {
    _editCancelToken?.cancel();
    _editCancelToken = CancelToken();
    return _editCancelToken!;
  }

  CancelToken? _deleteCancelToken;

  CancelToken _getDeleteToken() {
    _deleteCancelToken?.cancel();
    _deleteCancelToken = CancelToken();
    return _deleteCancelToken!;
  }

  void init(UserEntity user) {
    emitSafe(
      state.copyWith(
        originalUser: user,
        draftDisplayName: user.displayName,
        draftPhoneNumber: user.phoneNumber ?? '',
      ),
    );
  }

  void pickPhoto(String filePath) {
    emitSafe(state.copyWith(pendingPhotoPath: filePath));
  }

  void updateDisplayName(String value) {
    emitSafe(state.copyWith(draftDisplayName: value));
  }

  void updatePhoneNumber(String value) {
    emitSafe(state.copyWith(draftPhoneNumber: value));
  }

  void updateBio(String value) {
    if (!isClosed) {
      emit(state.copyWith(draftBio: value));
    }
  }

  Future<void> saveChanges() async {
    if (!state.hasChanges) return;
    _getEditToken();
    emitSafe(state.copyWith(saveStatus: EditSaveStatus.saving));
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
          emitSafe(
            state.copyWith(
              saveStatus: EditSaveStatus.failed,
              editErrorMessage: f.message,
            ),
          );

          return true;
        },
        cancelled: () => true,
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
          emitSafe(
            state.copyWith(
              saveStatus: EditSaveStatus.failed,
              editErrorMessage: f.message,
            ),
          );
          return true;
        },
        cancelled: () => true,
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
    emitSafe(
      state.copyWith(
        saveStatus: EditSaveStatus.success,
        // clearPendingPhoto: true,
      ),
    );
  }

  // reset and clean
  void dismissError() {
    emitSafe(
      state.copyWith(
        saveStatus: EditSaveStatus.idle,
        deleteStatus: DeleteAccountStatus.idle,
      ),
    );
  }

  Future<void> deleteAccount() async {
    _getDeleteToken();
    emitSafe(state.copyWith(deleteStatus: DeleteAccountStatus.deleting));

    final result = await _deleteAccountUseCase.call();
    result.when(
      success: (_) {
        emitSafe(state.copyWith(deleteStatus: DeleteAccountStatus.deleted));
      },
      failure: (f) {
        emitSafe(
          state.copyWith(
            deleteStatus: DeleteAccountStatus.failed,
            deleteErrorMessage: f.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  @override
  Future<void> close() {
    _editCancelToken?.cancel();
    _deleteCancelToken?.cancel();
    return super.close();
  }
}
