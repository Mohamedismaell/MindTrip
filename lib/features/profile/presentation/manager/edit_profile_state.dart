part of 'edit_profile_cubit.dart';

enum EditSaveStatus { idle, saving, success, failed }

class EditProfileState extends Equatable {
  final UserEntity? originalUser;
  final String? pendingPhotoPath;
  final String draftDisplayName;
  final String draftPhoneNumber;
  final EditSaveStatus saveStatus;
  final String? errorMessage;

  const EditProfileState({
    this.originalUser,
    this.pendingPhotoPath,
    this.draftDisplayName = '',
    this.draftPhoneNumber = '',
    this.saveStatus = EditSaveStatus.idle,
    this.errorMessage,
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
    String? errorMessage,
    bool clearPendingPhoto = false,
    bool clearError = false,
  }) {
    return EditProfileState(
      originalUser: originalUser ?? this.originalUser,
      pendingPhotoPath: clearPendingPhoto
          ? null
          : (pendingPhotoPath ?? this.pendingPhotoPath),
      draftDisplayName: draftDisplayName ?? this.draftDisplayName,
      draftPhoneNumber: draftPhoneNumber ?? this.draftPhoneNumber,
      saveStatus: saveStatus ?? this.saveStatus,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    originalUser,
    pendingPhotoPath,
    draftDisplayName,
    draftPhoneNumber,
    saveStatus,
    errorMessage,
  ];
}
