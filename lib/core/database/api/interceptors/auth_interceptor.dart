import 'package:dio/dio.dart';
import 'package:mindtrip/core/stoarge/secure_token_storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureTokenStorage storage;

  AuthInterceptor(this.storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await storage.clearTokens();
    }

    handler.next(err);
  }
}
