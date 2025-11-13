import 'package:dio/dio.dart';

import 'end_points.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.baseUrl = EndPoints.baseUrl;

    super.onRequest(options, handler);
  }
}
