import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String displayName;
  final String email;
  final String? phoneNumber;
  final String? profilePhotoUrl;
  final String? languagePreference;
  final List<String>? interests;

  const UserEntity({
    required this.userId,
    required this.displayName,
    required this.email,
    this.phoneNumber,
    this.profilePhotoUrl,
    this.languagePreference,
    this.interests,
  });

  @override
  List<Object?> get props => [
    userId,
    displayName,
    email,
    phoneNumber,
    profilePhotoUrl,
    languagePreference,
    interests,
  ];

  UserEntity copyWith({
    String? userId,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? profilePhotoUrl,
    String? languagePreference,
    List<String>? interests,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      languagePreference: languagePreference ?? this.languagePreference,
      interests: interests ?? this.interests,
    );
  }
}

