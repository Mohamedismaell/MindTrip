import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String userId;
  final String displayName;
  final String email;
  final String? profilePhotoUrl;
  final String? languagePreference;

  const UserModel({
    required this.userId,
    required this.displayName,
    required this.email,
    this.profilePhotoUrl,
    this.languagePreference,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      languagePreference: json['languagePreference'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'profilePhotoUrl': profilePhotoUrl,
      'languagePreference': languagePreference,
    };
  }

  factory UserModel.fromJsonString(String source) =>
      UserModel.fromJson(json.decode(source) as Map<String, dynamic>);

  String toJsonString() => json.encode(toJson());

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      displayName: displayName,
      email: email,
      profilePhotoUrl: profilePhotoUrl,
      languagePreference: languagePreference,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      userId: entity.userId,
      displayName: entity.displayName,
      email: entity.email,
      profilePhotoUrl: entity.profilePhotoUrl,
      languagePreference: entity.languagePreference,
    );
  }

  UserModel copyWith({
    String? userId,
    String? displayName,
    String? email,
    String? profilePhotoUrl,
    String? languagePreference,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      languagePreference: languagePreference ?? this.languagePreference,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    displayName,
    email,
    profilePhotoUrl,
    languagePreference,
  ];
}
