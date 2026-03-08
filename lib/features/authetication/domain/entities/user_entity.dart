import 'package:equatable/equatable.dart';

/// [DOMAIN LAYER] — Entity
///
/// [UserEntity] is a pure domain object that represents an authenticated user.
/// It lives in the domain layer and has **zero** dependency on any framework,
/// API response shape, or database schema.
class UserEntity extends Equatable {
  final String userId;
  final String displayName;
  final String email;
  final String? profilePhotoUrl;
  final String? languagePreference;

  const UserEntity({
    required this.userId,
    required this.displayName,
    required this.email,
    this.profilePhotoUrl,
    this.languagePreference,
  });

  @override
  List<Object?> get props => [
    userId,
    displayName,
    email,
    profilePhotoUrl,
    languagePreference,
  ];
}
