import 'package:dio/dio.dart';

sealed class AppException implements Exception {
  final String message;
  final int? statusCode;
  final Object? cause;

  const AppException(this.message, {this.statusCode, this.cause});

  @override
  String toString() => 'AppException(message: $message, statusCode: $statusCode, cause: $cause)';
}

final class NetworkException extends AppException {
  const NetworkException(
    super.message, {
      super.statusCode,
      super.cause
    }
  );
}

final class ServerException extends AppException {
  const ServerException(
    super.message, {
      super.statusCode,
      super.cause
    }
  );
}

final class TimeoutException extends AppException {
  const TimeoutException(
    super.message, {
      super.statusCode,
      super.cause
    }
  );
}

final class AuthException extends AppException {
  const AuthException(
    super.message, {
      super.statusCode,
      super.cause
    }
  );
}

final class ValidationException extends AppException {
  const ValidationException(
    super.message, {
      super.statusCode,
      super.cause
    }
  );
}

final class UnknownException extends AppException {
  const UnknownException(
    super.message, {
      super.statusCode,
      super.cause
    }
  );
}

AppException mapToAppException(Object error, [StackTrace? stackTrace]) {
  if (error is AppException) return error;

  if(error is DioException) {
    final statusCode = error.response?.statusCode;

    switch(error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          'Request timed out. Please Try again in a few minutes.',
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        return NetworkException(
          'Network Connection Failed. Please Try Again.',
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.badResponse:
        if(statusCode == 401 || statusCode == 403) {
          return AuthException(
            'This request is Unauthorized.',
            statusCode: statusCode,
            cause: error,
          );
        }
        // TODO: This is the exception where it should be placed under the text.
        if(statusCode == 422) {
          return ValidationException(
            'Validation Failed. Please check your input and try again.',
            statusCode: statusCode,
            cause: error,
          );
        }

        return ServerException(
          'Server Error Occurred.',
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.cancel:
        return NetworkException(
          'Request cancelled by user.',
          statusCode: statusCode,
          cause: error,
        );
      case DioExceptionType.unknown:
        return UnknownException(
          'Unexpected network error',
          statusCode: statusCode,
          cause: error,
        );
    }
  }
  return UnknownException(
  'Unexpected application error',
  cause: error,
  );
}