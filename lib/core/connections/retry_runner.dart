import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mindtrip/core/connections/retry_queue.dart';

class RetryRunner {
  RetryRunner(this.dio, this.queue);

  final Dio dio;
  final RetryQueue queue;

  Future<void> retryAll() async {
    if (queue.isEmpty) return;

    final requests = queue.drain();
    debugPrint('RetryRunner: retrying ${requests.length} queued request(s)');

    for (final options in requests) {
      try {
        await dio.fetch(options);
      } catch (e) {
        debugPrint(
          'RetryRunner: failed to retry ${options.method} ${options.path}',
        );
      }
    }
  }
}
