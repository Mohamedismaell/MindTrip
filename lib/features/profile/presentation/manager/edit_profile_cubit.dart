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
    final parsed = _splitPhoneNumber(user.phoneNumber);

    emitSafe(
      state.copyWith(
        originalUser: user,
        draftDisplayName: user.displayName,
        draftPhoneNumber: parsed.localNumber,
        draftPhoneCountryCode: parsed.countryCode,
        draftPhoneDialCode: parsed.dialCode,
        draftBio: user.bio ?? '',
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

  void updatePhoneCountry({
    required String countryCode,
    required String dialCode,
  }) {
    emitSafe(
      state.copyWith(
        draftPhoneCountryCode: countryCode,
        draftPhoneDialCode: dialCode,
      ),
    );
  }

  void updateBio(String value) {
    emitSafe(state.copyWith(draftBio: value));
  }

  Future<void> saveChanges() async {
    if (!state.hasChanges) return;

    _getEditToken();
    emitSafe(state.copyWith(saveStatus: EditSaveStatus.saving));

    String? newPhotoUrl;

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

    final normalizedLocalPhone = _normalizePhone(state.draftPhoneNumber);
    final fullPhoneNumber = normalizedLocalPhone.isEmpty
        ? ''
        : '+${state.draftPhoneDialCode}$normalizedLocalPhone';

    final originalParsed = _splitPhoneNumber(state.originalUser?.phoneNumber);
    final originalFullPhone = originalParsed.fullPhone;

    final nameChanged =
        state.draftDisplayName != state.originalUser?.displayName;
    final phoneChanged = fullPhoneNumber != originalFullPhone;
    final bioChanged = state.draftBio != (state.originalUser?.bio ?? '');

    if (nameChanged || phoneChanged || bioChanged) {
      final profileResult = await _updateProfile(
        displayName: nameChanged ? state.draftDisplayName : null,
        phoneNumber: phoneChanged ? fullPhoneNumber : null,
        bio: bioChanged ? state.draftBio : null,
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

    if (state.originalUser != null) {
      final updated = state.originalUser!.copyWith(
        displayName: state.draftDisplayName,
        phoneNumber: fullPhoneNumber,
        profilePhotoUrl: newPhotoUrl ?? state.originalUser!.profilePhotoUrl,
        bio: state.draftBio,
      );
      _userCubit.setUser(updated);
    }

    emitSafe(state.copyWith(saveStatus: EditSaveStatus.success));
  }

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

  String _normalizePhone(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }

  _ParsedPhone _splitPhoneNumber(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return const _ParsedPhone(
        countryCode: 'EG',
        dialCode: '20',
        localNumber: '',
      );
    }

    final normalized = phone.trim().replaceAll(RegExp(r'[^0-9+]'), '');

    if (normalized.startsWith('+20')) {
      return _ParsedPhone(
        countryCode: 'EG',
        dialCode: '20',
        localNumber: normalized.substring(3),
      );
    }

    if (normalized.startsWith('+966')) {
      return _ParsedPhone(
        countryCode: 'SA',
        dialCode: '966',
        localNumber: normalized.substring(4),
      );
    }

    if (normalized.startsWith('+971')) {
      return _ParsedPhone(
        countryCode: 'AE',
        dialCode: '971',
        localNumber: normalized.substring(4),
      );
    }

    if (normalized.startsWith('+1')) {
      return _ParsedPhone(
        countryCode: 'US',
        dialCode: '1',
        localNumber: normalized.substring(2),
      );
    }

    if (normalized.startsWith('+44')) {
      return _ParsedPhone(
        countryCode: 'GB',
        dialCode: '44',
        localNumber: normalized.substring(3),
      );
    }

    return _ParsedPhone(
      countryCode: 'EG',
      dialCode: '20',
      localNumber: normalized.replaceFirst('+', ''),
    );
  }

  @override
  Future<void> close() {
    _editCancelToken?.cancel();
    _deleteCancelToken?.cancel();
    return super.close();
  }
}

class _ParsedPhone {
  final String countryCode;
  final String dialCode;
  final String localNumber;

  const _ParsedPhone({
    required this.countryCode,
    required this.dialCode,
    required this.localNumber,
  });

  String get fullPhone => localNumber.isEmpty ? '' : '+$dialCode$localNumber';
}
