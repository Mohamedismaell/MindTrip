import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/user/data/models/user_model.dart';

part 'auth_response_model.freezed.dart';

@freezed
sealed class AuthResponseModel with _$AuthResponseModel {
  const AuthResponseModel._();

  const factory AuthResponseModel({
    required UserModel user,

    required String accessToken,

    required String refreshToken,

    @Default('Bearer') String tokenType,

    @Default(0) int expiresIn,

    @Default(false) bool isEmailVerified,

    @Default(false) bool twoFactorEnabled,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json),

      accessToken: json['accessToken'] as String,

      refreshToken: json['refreshToken'] as String,

      tokenType: json['tokenType'] as String? ?? 'Bearer',

      expiresIn: json['expiresIn'] as int? ?? 0,

      isEmailVerified: json['isEmailVerified'] as bool? ?? false,

      twoFactorEnabled: json['twoFactorEnabled'] as bool? ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      ...user.toJson(),

      'accessToken': accessToken,

      'refreshToken': refreshToken,

      'tokenType': tokenType,

      'expiresIn': expiresIn,

      'isEmailVerified': isEmailVerified,

      'twoFactorEnabled': twoFactorEnabled,
    };
  }
}
