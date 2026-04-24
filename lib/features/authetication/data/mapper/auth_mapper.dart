import 'package:mindtrip/features/authetication/data/models/auth_response_model.dart';
import 'package:mindtrip/features/authetication/domain/entities/auth_tokens.dart';

extension AuthResponseMapper on AuthResponseModel {
  AuthTokens toAuthTokens() {
    return AuthTokens(
      accessToken: accessToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
      refreshToken: refreshToken,
    );
  }
}

//! If we ever need to go back
extension AuthTokensMapper on AuthTokens {}
