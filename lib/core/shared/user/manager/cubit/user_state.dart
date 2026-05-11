part of 'user_cubit.dart';

enum UserStatus { initial, loading, loaded, error }

enum InterestStatus { idle, saving, saved, failed }

enum PhotoUploadStatus { idle, uploading, success, failed }

class UserState extends Equatable {
  final UserEntity? user;
  final UserStatus userStatus;
  final String? userErrorMessage;
  final PhotoUploadStatus photoUploadStatus;
  final String? localPhotoPath;
  final List<String>? interests;
  final InterestStatus interestStatus;
  final String? interestErrorMessage;
  final String? photoUploadErrorMessage;
  const UserState({
    this.user,
    this.userStatus = UserStatus.initial,
    this.userErrorMessage,
    this.photoUploadStatus = PhotoUploadStatus.idle,
    this.localPhotoPath,
    this.interests = const [],
    this.interestStatus = InterestStatus.idle,
    this.interestErrorMessage,
    this.photoUploadErrorMessage,
  });
  //* if changed return true
  bool get hasChanges {
    if (user == null) return false;
    final original = List<String>.from(user!.interests ?? [])..sort();
    final current = List<String>.from(interests ?? [])..sort();
    if (original.length != current.length) return true;
    for (int i = 0; i < original.length; i++) {
      if (original[i] != current[i]) return true;
    }
    return false;
  }

  UserState copyWith({
    UserEntity? user,
    UserStatus? userStatus,
    String? userErrorMessage,
    PhotoUploadStatus? photoUploadStatus,
    String? localPhotoPath,
    bool clearLocalPath = false,
    List<String>? interests,
    InterestStatus? interestStatus,
    String? interestErrorMessage,
    String? photoUploadErrorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      userStatus: userStatus ?? this.userStatus,
      userErrorMessage: userErrorMessage ?? this.userErrorMessage,
      photoUploadStatus: photoUploadStatus ?? this.photoUploadStatus,
      localPhotoPath: clearLocalPath
          ? null
          : (localPhotoPath ?? this.localPhotoPath),
      interests: interests ?? this.interests,
      interestErrorMessage: interestErrorMessage ?? this.interestErrorMessage,
      interestStatus: interestStatus ?? this.interestStatus,
      photoUploadErrorMessage:
          photoUploadErrorMessage ?? this.photoUploadErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    user,
    userStatus,
    userErrorMessage,
    photoUploadStatus,
    localPhotoPath,
    interests,
    interestStatus,
    interestErrorMessage,
    photoUploadErrorMessage,
  ];
}
