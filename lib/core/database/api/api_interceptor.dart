import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/network_info.dart';
import 'package:mindtrip/core/connections/retry_queue.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/errors/exceptions/no_internet_exception.dart';

class ApiInterceptor extends Interceptor {
  final NetworkInfo networkInfo;
  final RetryQueue retryQueue;

  ApiInterceptor(this.networkInfo, this.retryQueue);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.baseUrl = EndPoints.baseUrl;

    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      retryQueue.add(options);
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const NoInternetException(),
          type: DioExceptionType.unknown,
        ),
      );
    }

    handler.next(options);
  }
}
