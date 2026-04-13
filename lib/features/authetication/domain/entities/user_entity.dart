import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String displayName;
  final String email;
  final String? profilePhotoUrl;
  final String? languagePreference;
  final List<String>? interests;

  const UserEntity({
    required this.userId,
    required this.displayName,
    required this.email,
    this.profilePhotoUrl,
    this.languagePreference,
    this.interests,
  });

  @override
  List<Object?> get props => [
    userId,
    displayName,
    email,
    profilePhotoUrl,
    languagePreference,
    interests,
  ];
}
