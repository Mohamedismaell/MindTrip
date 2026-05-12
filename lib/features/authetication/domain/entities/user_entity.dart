import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
sealed class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String userId,
    required String displayName,
    required String email,

    String? phoneNumber,
    String? profilePhotoUrl,
    String? languagePreference,

    List<String>? interests,
  }) = _UserEntity;
}
