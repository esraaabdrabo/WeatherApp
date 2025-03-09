import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:weather_app/services/app_exception.dart';

class AppErrorHandler {
  static AppException? handle({Response? response, Object? exception}) {
    if (exception is AppException) {
      return exception;
    }
    if (response != null) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic>? error = data['error'];
      if (error != null) {
        if (error['code'] == 2008) {
          return AppException(
            ErrorMessages.serviceDown,
            response.statusCode,
          );
        }
        return AppException(error['message'], response.statusCode);
      }
    }
    if (exception is SocketException) {
      return const AppException(
        ErrorMessages.noInternet,
        500,
      );
    } else {
      return AppException(
        ErrorMessages.genericError,
        response?.statusCode ?? 500,
      );
    }
  }
}

class ErrorMessages {
  static const String serviceDown =
      'The service is down for some reason, try again later.';
  static const String noInternet =
      'Please check your internet connection and try again.';
  static const String genericError =
      'Failed to get weather data, please try again later.';
}
