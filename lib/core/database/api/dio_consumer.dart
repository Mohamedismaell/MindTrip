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
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
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
      data: isFormData ? FormData.fromMap(data) : data,
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
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      path,
      data: isFormData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
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
    CancelToken? cancelToken,
  }) async {
    final response = await dio.patch(
      path,
      data: isFormData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.post(
      path,
      data: isFormData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.put(
      path,
      data: isFormData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
