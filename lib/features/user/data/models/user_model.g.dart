// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  userId: json['userId'] as String,
  displayName: json['displayName'] as String,
  email: json['email'] as String,
  bio: json['bio'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  profilePhotoUrl: json['profilePhotoUrl'] as String?,
  languagePreference: json['languagePreference'] as String?,
  homeGovernorate: json['homeGovernorate'] as String?,
  interests: (json['interests'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'email': instance.email,
      'bio': instance.bio,
      'phoneNumber': instance.phoneNumber,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'languagePreference': instance.languagePreference,
      'homeGovernorate': instance.homeGovernorate,
      'interests': instance.interests,
    };
