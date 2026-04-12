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

  //! catch may got error ?
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
    } catch (_) {
      await authLocalDataSource.clear();
      return null;
    }
  }
}
