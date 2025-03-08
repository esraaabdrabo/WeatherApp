import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/app_exception.dart';

class AppErrorHandler {
  static AppException? handle({http.Response? response, Object? exception}) {
    if (exception is AppException) {
      return exception;
    }
    if (response != null) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic>? error = data['error'];
      if (error != null) {
        if (error['code'] == 2008) {
          return AppException(
            'The service is down for some reason try again later.',
            response.statusCode,
          );
        }
        return AppException(error['message'], response.statusCode);
      }
    }
    if (exception is SocketException) {
      return const AppException(
        'Please check your internet connection and try again.',
        500,
      );
    } else {
      return AppException(
        'Failed to get weather data, please try again later.',
        response?.statusCode ?? 500,
      );
    }
  }
}
