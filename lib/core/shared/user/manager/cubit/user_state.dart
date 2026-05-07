part of 'user_cubit.dart';

enum UserStatus { initial, loading, loaded, error }

enum PhotoUploadStatus { idle, uploading, success, failed }

class UserState extends Equatable {
  final UserEntity? user;
  final UserStatus status;
  final String? message;
  final PhotoUploadStatus photoUploadStatus;
  final String? localPhotoPath;
  final List<String>? interests;
  const UserState({
    this.user,
    this.status = UserStatus.initial,
    this.message,
    this.photoUploadStatus = PhotoUploadStatus.idle,
    this.localPhotoPath,
    this.interests = const [],
  });

  UserState copyWith({
    UserEntity? user,
    UserStatus? status,
    String? message,
    PhotoUploadStatus? photoUploadStatus,
    String? localPhotoPath,
    bool clearLocalPath = false,
    List<String>? interests,
  }) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message,
      photoUploadStatus: photoUploadStatus ?? this.photoUploadStatus,
      localPhotoPath: clearLocalPath
          ? null
          : (localPhotoPath ?? this.localPhotoPath),
      interests: interests ?? this.interests,
    );
  }

  @override
  List<Object?> get props => [
    user,
    status,
    message,
    photoUploadStatus,
    localPhotoPath,
    interests,
  ];
}
