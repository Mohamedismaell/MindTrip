import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String displayName,
    required String email,
    String? bio,

    String? phoneNumber,
    String? profilePhotoUrl,
    String? languagePreference,
    String? homeGovernorate,

    List<String>? interests,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
