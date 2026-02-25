import 'package:dio/dio.dart';

class RetryQueue {
  final List<RequestOptions> queue = [];

  void add(RequestOptions options) {
    queue.add(options);
    print('queue  ===> $queue');
  }

  List<RequestOptions> drain() {
    final copy = List<RequestOptions>.from(queue);
    queue.clear();
    return copy;
  }

  bool get isEmpty => queue.isEmpty;
}
