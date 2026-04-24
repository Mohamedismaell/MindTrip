import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String displayName;
  final String email;
  final String? phoneNumber;
  final String? profilePhotoUrl;
  final String? languagePreference;
  final String? homeGovernorate;
  final List<String>? interests;
  const UserModel({
    required this.userId,
    required this.displayName,
    required this.email,
    this.phoneNumber,
    this.profilePhotoUrl,
    this.languagePreference,
    this.homeGovernorate,
    //!Check Could be empty ?
    this.interests,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      languagePreference: json['languagePreference'] as String?,
      homeGovernorate: json['homeGovernorate'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePhotoUrl': profilePhotoUrl,
      'languagePreference': languagePreference,
      'homeGovernorate': homeGovernorate,
      'interests': interests,
    };
  }

  factory UserModel.fromJsonString(String source) =>
      UserModel.fromJson(json.decode(source) as Map<String, dynamic>);

  String toJsonString() => json.encode(toJson());

  UserModel copyWith({
    String? userId,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? profilePhotoUrl,
    String? languagePreference,
    String? homeGovernorate,
    List<String>? interests,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      languagePreference: languagePreference ?? this.languagePreference,
      homeGovernorate: homeGovernorate ?? this.homeGovernorate,
      interests: interests ?? this.interests,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    displayName,
    email,
    phoneNumber,
    profilePhotoUrl,
    languagePreference,
    homeGovernorate,
    interests,
  ];
}
