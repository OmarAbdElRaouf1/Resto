import 'package:dio/dio.dart';
import 'package:resto/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (statusCode != null) {
      if (data is Map<String, dynamic> && data['message'] != null) {
        return ApiError(message: data['message'], code: statusCode);
      }
    }

    if (statusCode == 302) {
      return ApiError(message: 'This Email Already Taken', code: statusCode);
    }

    if (statusCode == 429) {
      return ApiError(
        message: 'Too many requests. Please wait a moment and try again',
        code: statusCode,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: "Connection timeout. Please check your internet connection",
        );
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request timeout. Please try again");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Response timeout. Please try again");
      default:
        return ApiError(
          message: "An unexpected error occurred. Please try again",
        );
    }
  }
}
