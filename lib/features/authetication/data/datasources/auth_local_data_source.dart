import 'package:mindtrip/core/stoarge/secure_token_storage.dart';

class AuthLocalDataSource {
  final SecureTokenStorage _storage;

  AuthLocalDataSource({required SecureTokenStorage storage})
    : _storage = storage;

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.saveAccessToken(accessToken);
    if (refreshToken != null) {
      await _storage.saveRefreshToken(refreshToken);
    }
  }

  Future<String?> getAccessToken() async {
    return _storage.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return _storage.getRefreshToken();
  }

  Future<bool> hasSession() async {
    final token = await _storage.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clear() async {
    await _storage.clearTokens();
  }
}
