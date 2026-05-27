import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Dio interceptor that automatically retries transient network errors
/// (timeouts, connection errors, and 5xx server errors) with exponential backoff.
///
/// Non-retryable errors (4xx, cancelled requests) are passed through immediately.
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration baseDelay;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 1),
  });

  static const _retryCountKey = '_retry_count';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRetry(err)) {
      return handler.next(err);
    }

    final retryCount = (err.requestOptions.extra[_retryCountKey] as int?) ?? 0;

    if (retryCount >= maxRetries) {
      return handler.next(err);
    }

    final delay = baseDelay * (1 << retryCount); // 1s → 2s → 4s
    debugPrint(
      '🔄 Retry ${retryCount + 1}/$maxRetries '
      'for ${err.requestOptions.method} ${err.requestOptions.path} '
      'in ${delay.inSeconds}s',
    );

    await Future.delayed(delay);

    err.requestOptions.extra[_retryCountKey] = retryCount + 1;

    try {
      final response = await dio.fetch(err.requestOptions);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  bool _shouldRetry(DioException err) {
    // Never retry cancelled requests
    if (CancelToken.isCancel(err)) return false;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        final code = err.response?.statusCode ?? 0;
        return code >= 500; // Only retry server errors
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return false;
    }
  }
}
