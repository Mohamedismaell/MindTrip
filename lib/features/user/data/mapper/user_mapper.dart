import 'package:mindtrip/features/user/data/models/user_model.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

extension UserMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      displayName: displayName,
      email: email,
      phoneNumber: phoneNumber,
      profilePhotoUrl: profilePhotoUrl,
      languagePreference: languagePreference,
      interests: interests,
      bio: bio,
    );
  }
}

extension UserEntityMapper on UserEntity {
  UserModel toModel() {
    return UserModel(
      userId: userId,
      displayName: displayName,
      email: email,
      phoneNumber: phoneNumber,
      profilePhotoUrl: profilePhotoUrl,
      languagePreference: languagePreference,
      interests: interests,
      bio: bio,
    );
  }
}
