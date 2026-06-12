import 'package:dio/dio.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_remote_data_source.dart';
import 'package:mindtrip/features/authetication/data/models/auth_response_model.dart';

class TokenManager {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  bool _isRefreshing = false;
  Future<AuthResponseModel?>? _refreshFuture;

  TokenManager({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  Future<String?> getAccessToken() async {
    final accessToken = await authLocalDataSource.getAccessToken();
    return accessToken;
  }

  Future<AuthResponseModel?> refreshIfNeeded() async {
    final refreshToken = await authLocalDataSource.getRefreshToken();
    if (refreshToken == null) return null;

    if (_isRefreshing) {
      return _refreshFuture;
    }

    _isRefreshing = true;

    _refreshFuture = _refresh(refreshToken: refreshToken);

    final newTokens = await _refreshFuture;

    _isRefreshing = false;

    return newTokens;
  }

  Future<AuthResponseModel?> _refresh({required String refreshToken}) async {
    try {
      final newTokens = await authRemoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );
      await authLocalDataSource.clear();
      await authLocalDataSource.saveTokens(
        accessToken: newTokens.accessToken,
        refreshToken: newTokens.refreshToken,
      );
      return newTokens;
    } on DioException catch (e) {
      // Only wipe credentials when the server explicitly rejects the refresh
      // token (401/403). Transient errors (timeout, no network, 5xx) should
      // NOT clear the tokens — the user's session is still valid.
      final status = e.response?.statusCode;
      if (status == 401 || status == 403) {
        await authLocalDataSource.clear();
      }
      return null;
    } catch (_) {
      // Non-Dio errors (e.g. parse failures) — don't clear tokens.
      return null;
    }
  }
}
