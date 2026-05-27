import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RetryQueue {
  final List<RequestOptions> _queue = [];
  final int maxSize;

  RetryQueue({this.maxSize = 20});

  void add(RequestOptions options) {
    // Deduplicate by method + path
    final key = '${options.method}:${options.path}';
    final exists = _queue.any((o) => '${o.method}:${o.path}' == key);
    if (exists) {
      debugPrint('RetryQueue: skipping duplicate $key');
      return;
    }

    if (_queue.length >= maxSize) {
      debugPrint('RetryQueue: at capacity ($maxSize), dropping oldest');
      _queue.removeAt(0);
    }

    _queue.add(options);
    debugPrint('RetryQueue: enqueued $key (${_queue.length} pending)');
  }

  List<RequestOptions> drain() {
    final copy = List<RequestOptions>.from(_queue);
    _queue.clear();
    return copy;
  }

  bool get isEmpty => _queue.isEmpty;
}
