import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/authetication/data/models/user_model.dart';
import 'package:mindtrip/features/authetication/domain/entities/auth_tokens.dart';

class AuthResponseModel extends Equatable {
  final UserModel user;
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  const AuthResponseModel({
    required this.user,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json),
      accessToken: json['accessToken'] as String,
      tokenType: json['tokenType'] as String? ?? 'Bearer',
      expiresIn: json['expiresIn'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ...user.toJson(),
      'accessToken': accessToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
    };
  }

  factory AuthResponseModel.fromJsonString(String source) =>
      AuthResponseModel.fromJson(json.decode(source) as Map<String, dynamic>);

  String toJsonString() => json.encode(toJson());

  AuthTokens toAuthTokens() {
    return AuthTokens(
      accessToken: accessToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
    );
  }

  @override
  List<Object?> get props => [user, accessToken, tokenType, expiresIn];
}
