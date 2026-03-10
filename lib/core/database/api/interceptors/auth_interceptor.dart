import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/auth/secure_token_storage.dart';
import 'package:mindtrip/core/shared/auth/token_manager.dart';

class AuthInterceptor extends Interceptor {
  final SecureTokenStorage storage;
  final TokenManager Function() getTokenManager;
  final Dio dio;

  AuthInterceptor({
    required this.storage,
    required this.getTokenManager,
    required this.dio,
  });

  TokenManager get tokenManager => getTokenManager();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenManager.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers[ApiKeys.authorization] = "${ApiKeys.bearer} $token";
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // ignore refresh endpoint
    if (err.requestOptions.path.contains(EndPoints.refreshToken)) {
      handler.next(err);
      return;
    }

    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    final newTokens = await tokenManager.refreshIfNeeded();

    if (newTokens == null) {
      handler.reject(err);
      return;
    }

    final request = err.requestOptions;

    request.headers[ApiKeys.authorization] =
        "${ApiKeys.bearer} ${newTokens.accessToken}";

    try {
      final response = await dio.fetch(request);
      handler.resolve(response);
    } catch (_) {
      handler.reject(err);
    }
  }
}
