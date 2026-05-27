import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindtrip/core/errors/exceptions/no_internet_exception.dart';
import 'package:mindtrip/core/errors/failure/failure.dart';

class ApiErrorMapper {
  static Failure fromException(Object e) {
    if (kDebugMode) {
      print("ERROR TYPE: ${e.runtimeType}");
      print("ERROR OBJECT: $e");
    }
    if (e is DioException && CancelToken.isCancel(e)) {
      return const CancelledFailure();
    }
    if (e is DioException) {
      return fromDioException(e);
    }

    // if (e is PostgrestException) {
    //   return ServerFailure(e.message);
    // }

    // if (e is AuthException) {
    //   return UnauthorizedFailure(message: e.message);
    // }
    if (e is GoogleSignInException) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return const CancelledFailure();
      }

      return ServerFailure(e.description ?? 'Google sign in failed');
    }

    if (e is SocketException) {
      return NetworkFailure(message: 'No internet connection');
    }

    return const UnknownFailure();
  }

  static Failure fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkFailure(
          message: 'Connection timed out',
          debugMessage: e.message,
        );

      case DioExceptionType.sendTimeout:
        return NetworkFailure(
          message: 'Request timed out',
          debugMessage: e.message,
        );

      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          message: 'Server took too long to respond',
          debugMessage: e.message,
        );

      case DioExceptionType.connectionError:
        return NetworkFailure(
          message: 'No internet connection',
          debugMessage: e.message,
        );
      case DioExceptionType.badCertificate:
        return const NetworkFailure(message: 'Secure connection failed');

      case DioExceptionType.badResponse:
        return _mapBadResponse(e);
      case DioExceptionType.cancel:
        return const CancelledFailure();
      case DioExceptionType.unknown:
        if (e.error is NoInternetException || e.error is SocketException) {
          return const NetworkFailure(message: 'No internet connection');
        }
        return const UnknownFailure();
    }
  }

  static Failure _mapBadResponse(DioException e) {
    final response = e.response;

    if (response == null) {
      return const ServerFailure('Server error');
    }

    final statusCode = response.statusCode ?? 0;
    final data = response.data;

    if (statusCode == 401) {
      return UnauthorizedFailure(message: _extractMessage(data));
    }

    if (statusCode == 403) {
      return UnauthorizedFailure(message: _extractMessage(data));
    }

    if (statusCode == 404) {
      return ServerFailure(_extractMessage(data));
    }

    if (statusCode == 400) {
      return ServerFailure(_extractMessage(data));
    }

    return ServerFailure(_extractMessage(data), debugMessage: e.message);
  }

  static String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data['detail'] != null) return data['detail'].toString();
      if (data['title'] != null) return data['title'].toString();

      if (data['message'] != null) return data['message'].toString();
      if (data['errorMessage'] != null) return data['errorMessage'].toString();
      if (data['error'] != null) return data['error'].toString();

      if (data['errors'] is List && data['errors'].isNotEmpty) {
        return data['errors'].first.toString();
      }
    }

    return 'Server error occurred';
  }
}
