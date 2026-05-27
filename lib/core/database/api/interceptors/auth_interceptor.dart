import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/auth/secure_token_storage.dart';
import 'package:mindtrip/core/shared/auth/token_manager.dart';

class AuthInterceptor extends Interceptor {
  final SecureTokenStorage storage;
  final TokenManager Function() getTokenManager;
  final Dio dio;
  final Future<void> Function()? onLogout;

  AuthInterceptor({
    required this.storage,
    required this.getTokenManager,
    required this.dio,
    this.onLogout,
  });

  TokenManager get tokenManager => getTokenManager();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await tokenManager.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers[ApiKeys.authorization] = "${ApiKeys.bearer} $accessToken";
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final path = err.requestOptions.path;
    if (path.contains(EndPoints.refreshToken) ||
        path.contains(EndPoints.login) ||
        path.contains(EndPoints.register) ||
        path.contains(EndPoints.googleLogin) ||
        path.contains(EndPoints.facebookLogin) ||
        path.contains(EndPoints.verifyEmail) ||
        path.contains(EndPoints.verifyPasswordOtp) ||
        path.contains(EndPoints.resendEmailOtp) ||
        path.contains(EndPoints.resendPasswordOtp) ||
        path.contains(EndPoints.forgetPassword) ||
        path.contains(EndPoints.resetPassword)) {
      handler.next(err);
      return;
    }

    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    final newTokens = await tokenManager.refreshIfNeeded();

    if (newTokens == null) {
      // failed || session is expired ==> logout.
      await onLogout?.call();
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
