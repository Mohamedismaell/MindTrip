import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  static const reset = '\x1B[0m';
  static const yellow = '\x1B[33m';
  static const green = '\x1B[32m';
  static const red = '\x1B[31m';
  static const cyan = '\x1B[36m';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('''
$yellow┌────── 🚀 REQUEST ─────────────────────────────$reset
  $cyan│ ${options.method} ${options.uri}$reset
       │ Headers:
       ${_pretty(options.headers)}
       │ Body:
       ${_formatData(options.data)}
       │
       │ 🧪 CURL:
       ${_toCurl(options)}
$yellow└────────────────────────────────────────────$reset
''');

    options.extra['start_time'] = DateTime.now();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final start = response.requestOptions.extra['start_time'] as DateTime?;
    final duration = start != null
        ? DateTime.now().difference(start).inMilliseconds
        : 0;

    final logData = response.requestOptions.extra['logResponseData'] ?? true;

    debugPrint('''
        $green┌────── ✅ RESPONSE (${response.statusCode}) [$duration ms] ───$reset
         $cyan│ ${response.requestOptions.uri}$reset
              │ Data:
              ${logData ? _pretty(response.data) : '[Data Truncated for Performance]'}
        $green└────────────────────────────────────────────$reset
''');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('''
      $red┌────── ❌ ERROR ───────────────────────────────$reset
      $cyan│ ${err.requestOptions.method} ${err.requestOptions.uri}$reset
           │ Status: ${err.response?.statusCode}
           │ Message: ${err.message}
           │ Data:
      ${_pretty(err.response?.data)}
       $red└────────────────────────────────────────────$reset
''');

    handler.next(err);
  }

  String _formatData(dynamic data) {
    if (data is FormData) {
      final buffer = StringBuffer();

      buffer.writeln('📦 FormData:');

      for (final field in data.fields) {
        buffer.writeln('  📝 ${field.key}: ${field.value}');
      }

      for (final file in data.files) {
        final f = file.value;
        buffer.writeln('  📁 ${file.key}:');
        buffer.writeln('     • name: ${f.filename}');
        buffer.writeln('     • type: ${f.contentType}');
        buffer.writeln('     • size: ${f.length} bytes');
      }

      return buffer.toString();
    }

    return _pretty(data);
  }

  String _pretty(dynamic data) {
    try {
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (_) {
      return data.toString();
    }
  }

  String _toCurl(RequestOptions options) {
    final buffer = StringBuffer();

    buffer.write('curl -X ${options.method} "${options.uri}"');

    options.headers.forEach((k, v) {
      buffer.write(' -H "$k: $v"');
    });

    if (options.data is FormData) {
      final form = options.data as FormData;

      for (final field in form.fields) {
        buffer.write(' -F "${field.key}=${field.value}"');
      }

      for (final file in form.files) {
        buffer.write(' -F "${file.key}=@${file.value.filename}"');
      }
    }

    return buffer.toString();
  }
}
