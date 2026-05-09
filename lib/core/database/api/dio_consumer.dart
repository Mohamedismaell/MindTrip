import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/interceptors/logging_interceptor.dart';
import 'api_consumer.dart';
import 'interceptors/api_interceptor.dart';
import 'end_points.dart';
import 'interceptors/auth_interceptor.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  final ApiInterceptor apiInterceptor;
  final AuthInterceptor authInterceptor;
  final LoggingInterceptor loggingInterceptor;
  DioConsumer(
    this.dio,
    this.apiInterceptor,
    this.authInterceptor,
    this.loggingInterceptor,
  ) {
    dio.interceptors.addAll([
      apiInterceptor,
      authInterceptor,
      loggingInterceptor,
    ]);

    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.delete(
      path,
      data: _handleData(data, isFormData),
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      path,
      data: _handleData(data, isFormData),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    return response.data;
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.patch(
      path,
      data: _handleData(data, isFormData),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.post(
      path,
      data: _handleData(data, isFormData),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.put(
      path,
      data: _handleData(data, isFormData),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

dynamic _handleData(dynamic data, bool isFormData) {
  if (data == null) return null;
  if (data is FormData) return data;
  if (isFormData) return FormData.fromMap(data);
  return data;
}
