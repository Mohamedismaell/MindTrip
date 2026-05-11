part of 'edit_profile_cubit.dart';

enum EditSaveStatus { idle, saving, success, failed }

enum DeleteAccountStatus { idle, deleting, deleted, failed }

class EditProfileState extends Equatable {
  final UserEntity? originalUser;
  final String? pendingPhotoPath;
  final String draftDisplayName;
  final String draftPhoneNumber;
  final EditSaveStatus saveStatus;
  final String? editErrorMessage;
  final DeleteAccountStatus deleteStatus;
  final String? deleteErrorMessage;
  const EditProfileState({
    this.originalUser,
    this.pendingPhotoPath,
    this.draftDisplayName = '',
    this.draftPhoneNumber = '',
    this.saveStatus = EditSaveStatus.idle,
    this.editErrorMessage,
    this.deleteStatus = DeleteAccountStatus.idle,
    this.deleteErrorMessage,
  });

  //* if changed return true
  bool get hasChanges {
    if (originalUser == null) return false;
    if (pendingPhotoPath != null) return true;
    if (draftDisplayName != originalUser!.displayName) return true;
    if (draftPhoneNumber != (originalUser!.phoneNumber ?? '')) return true;
    return false;
  }

  EditProfileState copyWith({
    UserEntity? originalUser,
    String? pendingPhotoPath,
    String? draftDisplayName,
    String? draftPhoneNumber,
    EditSaveStatus? saveStatus,
    String? editErrorMessage,
    DeleteAccountStatus? deleteStatus,
    String? deleteErrorMessage,
  }) {
    return EditProfileState(
      originalUser: originalUser ?? this.originalUser,
      draftDisplayName: draftDisplayName ?? this.draftDisplayName,
      draftPhoneNumber: draftPhoneNumber ?? this.draftPhoneNumber,
      saveStatus: saveStatus ?? this.saveStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object?> get props => [
    originalUser,
    pendingPhotoPath,
    draftDisplayName,
    draftPhoneNumber,
    saveStatus,
    editErrorMessage,
    deleteStatus,
    deleteErrorMessage,
  ];
}
