import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kDebugMode) {
      handler.next(options);
      return;
    }

    options.extra['start_time'] = DateTime.now();

    debugPrint('''
┌────────────────────────────────────────────────────────
│ 🟡 REQUEST
│ ${options.method} ${options.baseUrl}${options.path}
│
│ Headers:
│ ${options.headers}
│
│ Query:
│ ${options.queryParameters}
│
│ Body:
│ ${options.data}
└────────────────────────────────────────────────────────
''');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kDebugMode) {
      handler.next(response);
      return;
    }

    final start = response.requestOptions.extra['start_time'] as DateTime?;
    final duration = start != null
        ? DateTime.now().difference(start).inMilliseconds
        : 0;

    debugPrint('''
┌────────────────────────────────────────────────────────
│ 🟢 RESPONSE (${response.statusCode}) [$duration ms]
│ ${response.requestOptions.method} ${response.requestOptions.path}
│
│ Data:
│ ${response.data}
└────────────────────────────────────────────────────────
''');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kDebugMode) {
      handler.next(err);
      return;
    }

    debugPrint('''
┌────────────────────────────────────────────────────────
│ 🔴 ERROR
│ ${err.requestOptions.method} ${err.requestOptions.path}
│
│ Status: ${err.response?.statusCode}
│ Message: ${err.message}
│
│ Response:
│ ${err.response?.data}
└────────────────────────────────────────────────────────
''');

    handler.next(err);
  }
}
