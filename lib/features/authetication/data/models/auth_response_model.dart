import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/user/data/models/user_model.dart';
class AuthResponseModel extends Equatable {
  final UserModel user;
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final bool isEmailVerified;
  final bool twoFactorEnabled;

  const AuthResponseModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.isEmailVerified,
    required this.twoFactorEnabled,
  });

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
      'tokenType': tokenType,
      'expiresIn': expiresIn,
      'refreshToken': refreshToken,
      'isEmailVerified': isEmailVerified,
      'twoFactorEnabled': twoFactorEnabled,
    };
  }

  factory AuthResponseModel.fromJsonString(String source) =>
      AuthResponseModel.fromJson(json.decode(source) as Map<String, dynamic>);

  String toJsonString() => json.encode(toJson());

  @override
  List<Object?> get props => [
    user,
    accessToken,
    tokenType,
    expiresIn,
    refreshToken,
  ];
}
