import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  static const reset = '\x1B[0m';
  static const yellow = '\x1B[33m';
  static const green = '\x1B[32m';
  static const red = '\x1B[31m';
  static const cyan = '\x1B[36m';

  static const int _maxBodyChars = 1200;
  static const int _maxCurlChars = 1000;
  static const int _maxListItems = 3;
  static const int _chunkSize = 800;

  final bool enabled;
  final bool logHeaders;
  final bool logRequestBody;
  final bool logResponseBody;
  final bool logCurl;

  const LoggingInterceptor({
    this.enabled = kDebugMode,
    this.logHeaders = true,
    this.logRequestBody = true,
    this.logResponseBody = true,
    this.logCurl = false,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!enabled) {
      handler.next(options);
      return;
    }

    options.extra['start_time'] = DateTime.now();

    final shouldLogHeaders = options.extra['logHeaders'] as bool? ?? logHeaders;
    final shouldLogRequestBody =
        options.extra['logRequestBody'] as bool? ?? logRequestBody;
    final shouldLogCurl = options.extra['logCurl'] as bool? ?? logCurl;

    final buffer = StringBuffer()
      ..writeln('$yellow┌────── 🚀 REQUEST ─────────────────────────────$reset')
      ..writeln('  $cyan│ ${options.method} ${options.uri}$reset');

    if (shouldLogHeaders) {
      buffer
        ..writeln('  │ Headers:')
        ..writeln(_indent(_prettyFull(options.headers)));
    }

    if (shouldLogRequestBody) {
      buffer
        ..writeln('  │ Body:')
        ..writeln(_indent(_formatData(options.data)));
    }

    if (shouldLogCurl) {
      buffer
        ..writeln('  │')
        ..writeln('  │ 🧪 CURL:')
        ..writeln(_indent(_truncateText(_toCurl(options), _maxCurlChars)));
    }

    buffer.writeln(
      '$yellow└────────────────────────────────────────────$reset',
    );

    _printChunked(buffer.toString());
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!enabled) {
      handler.next(response);
      return;
    }

    final start = response.requestOptions.extra['start_time'] as DateTime?;
    final duration = start != null
        ? DateTime.now().difference(start).inMilliseconds
        : 0;

    final shouldLogResponseBody =
        response.requestOptions.extra['logResponseData'] as bool? ??
        logResponseBody;

    final buffer = StringBuffer()
      ..writeln(
        '$green┌────── ✅ RESPONSE (${response.statusCode}) [$duration ms] ───$reset',
      )
      ..writeln('  $cyan│ ${response.requestOptions.uri}$reset');

    if (shouldLogResponseBody) {
      buffer
        ..writeln('  │ Data:')
        ..writeln(
          _indent(
            _pretty(_truncateStructure(response.data), maxChars: _maxBodyChars),
          ),
        );
    } else {
      buffer.writeln('  │ Data: [Skipped]');
    }

    buffer.writeln('$green└────────────────────────────────────────────$reset');

    _printChunked(buffer.toString());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!enabled) {
      handler.next(err);
      return;
    }

    final buffer = StringBuffer()
      ..writeln('$red┌────── ❌ ERROR ───────────────────────────────$reset')
      ..writeln(
        '  $cyan│ ${err.requestOptions.method} ${err.requestOptions.uri}$reset',
      )
      ..writeln('  │ Status: ${err.response?.statusCode}')
      ..writeln('  │ Message: ${err.message}');

    if (err.response?.data != null) {
      buffer
        ..writeln('  │ Data:')
        ..writeln(
          _indent(
            _pretty(
              _truncateStructure(err.response?.data),
              maxChars: _maxBodyChars,
            ),
          ),
        );
    }

    buffer.writeln('$red└────────────────────────────────────────────$reset');

    _printChunked(buffer.toString());
    handler.next(err);
  }

  String _formatData(dynamic data) {
    if (data == null) return 'null';

    if (data is FormData) {
      final buffer = StringBuffer()..writeln('📦 FormData:');

      for (final field in data.fields) {
        buffer.writeln('📝 ${field.key}: ${_truncateText(field.value, 120)}');
      }

      for (final file in data.files) {
        final f = file.value;
        buffer.writeln('📁 ${file.key}:');
        buffer.writeln('   • name: ${f.filename}');
        buffer.writeln('   • type: ${f.contentType}');
        buffer.writeln('   • size: ${f.length} bytes');
      }

      return _truncateText(buffer.toString(), _maxBodyChars);
    }

    return _pretty(_truncateStructure(data), maxChars: _maxBodyChars);
  }

  dynamic _truncateStructure(dynamic value) {
    if (value == null) return null;

    if (value is List) {
      if (value.isEmpty) return value;

      if (value.length <= _maxListItems) {
        return value.map(_truncateStructure).toList();
      }

      return {
        'count': value.length,
        'showing': _maxListItems,
        'items': value.take(_maxListItems).map(_truncateStructure).toList(),
        'truncated': true,
      };
    }

    if (value is Map) {
      final result = <dynamic, dynamic>{};
      value.forEach((key, val) {
        result[key] = _truncateLeaf(val);
      });
      return result;
    }

    return _truncateLeaf(value);
  }

  dynamic _truncateLeaf(dynamic value) {
    if (value is String) {
      return _truncateText(value, 200);
    }

    if (value is List || value is Map) {
      return _truncateStructure(value);
    }

    return value;
  }

  String _pretty(dynamic data, {int maxChars = _maxBodyChars}) {
    try {
      final text = const JsonEncoder.withIndent('  ').convert(data);
      return _truncateText(text, maxChars);
    } catch (_) {
      return _truncateText(data.toString(), maxChars);
    }
  }

  String _prettyFull(dynamic data) {
    try {
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (_) {
      return data.toString();
    }
  }

  String _truncateText(String text, int maxChars) {
    if (text.length <= maxChars) return text;
    return '${text.substring(0, maxChars)}... <truncated ${text.length - maxChars} chars>';
  }

  String _toCurl(RequestOptions options) {
    final buffer = StringBuffer();

    buffer.write('curl -X ${options.method} "${options.uri}"');

    options.headers.forEach((k, v) {
      buffer.write(' -H "$k: $v"');
    });

    final data = options.data;

    if (data is FormData) {
      for (final field in data.fields) {
        buffer.write(' -F "${field.key}=${_truncateText(field.value, 80)}"');
      }

      for (final file in data.files) {
        buffer.write(' -F "${file.key}=@${file.value.filename}"');
      }
    } else if (data != null) {
      final encoded = _truncateText(
        _oneLineJson(_truncateStructure(data)),
        300,
      );
      buffer.write(" --data '$encoded'");
    }

    return buffer.toString();
  }

  String _oneLineJson(dynamic data) {
    try {
      return jsonEncode(data);
    } catch (_) {
      return data.toString();
    }
  }

  String _indent(String text) {
    return text.split('\n').map((line) => '  $line').join('\n');
  }

  void _printChunked(String text) {
    for (var i = 0; i < text.length; i += _chunkSize) {
      debugPrint(
        text.substring(
          i,
          i + _chunkSize > text.length ? text.length : i + _chunkSize,
        ),
      );
    }
  }
}
