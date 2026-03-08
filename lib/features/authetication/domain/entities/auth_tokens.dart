import 'package:equatable/equatable.dart';

/// [DOMAIN LAYER] — Entity
///
/// [AuthTokens] holds the authentication tokens returned from a successful
/// sign-in / sign-up flow. This is a pure value object with no behaviour.
class AuthTokens extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  const AuthTokens({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  @override
  List<Object?> get props => [accessToken, tokenType, expiresIn];
}
