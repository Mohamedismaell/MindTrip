import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

part 'edit_profile_state.freezed.dart';

enum EditSaveStatus { idle, saving, success, failed }

enum DeleteAccountStatus { idle, deleting, deleted, failed }

@freezed
abstract class EditProfileState with _$EditProfileState {
  const EditProfileState._();

  const factory EditProfileState({
    UserEntity? originalUser,
    String? pendingPhotoPath,
    @Default('') String draftDisplayName,
    @Default('') String draftPhoneNumber,
    @Default('EG') String draftPhoneCountryCode,
    @Default('20') String draftPhoneDialCode,
    @Default('') String draftBio,
    @Default(EditSaveStatus.idle) EditSaveStatus saveStatus,
    String? editErrorMessage,
    @Default(DeleteAccountStatus.idle) DeleteAccountStatus deleteStatus,
    String? deleteErrorMessage,
  }) = _EditProfileState;

  String get fullDraftPhone {
    final normalized = draftPhoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (normalized.isEmpty) return '';
    return '+$draftPhoneDialCode$normalized';
  }

  bool get hasChanges {
    if (originalUser == null) return false;

    if (pendingPhotoPath != null &&
        pendingPhotoPath != originalUser!.profilePhotoUrl) {
      return true;
    }

    if (draftDisplayName != originalUser!.displayName) return true;

    final originalPhone = originalUser!.phoneNumber ?? '';
    if (fullDraftPhone != originalPhone) {
      return true;
    }

    if (draftBio != (originalUser!.bio ?? '')) {
      return true;
    }

    return false;
  }
}
