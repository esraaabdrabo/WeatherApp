import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  Future<WeatherModel?> getWeather({required String cityName}) async {
    final WeatherModel? weather;
    http.Response? response;
    try {
      //Todo this method is doing more than one job so it's violating the single responsibility principle, since it's responsible for
      // fetching the data and parsing it, so we need to separate the logic by creating http client which is responsible for requests only and return AppHttpResponse only then the parsing will be done her.
      String baseUrl = 'http://api.weatherapi.com/v1';

      String apiKey = '';
      Uri url = Uri.parse(
          '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=5&aqi=no&alerts=no');
      // need client.
      response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['error'] != null) {
        if (data['error']['code'] == 2008) {
          throw AppException(
            'The service is down for some reason try again later.',
            response.statusCode,
          );
        }
        throw AppException(data['error']['message'], response.statusCode);
      }
      weather = WeatherModel.fromJson(data);
    } catch (exception) {
      //{error: {code: 2008, message: API key has been disabled.}}
      if (exception is AppException) {
        rethrow;
      } else if (exception is SocketException) {
        throw const AppException(
          'Please check your internet connection and try again.',
          500,
        );
      }
      // the user has no idea what is the problem we need to show a message to the user.
      throw AppException(
        'Failed to get weather data',
        response?.statusCode ?? 500,
      );
    }

    return weather;
  }
}

class AppException implements Exception {
  final String message;
  final int code;

  const AppException(this.message, this.code);
}
