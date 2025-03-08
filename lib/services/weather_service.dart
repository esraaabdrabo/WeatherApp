import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/app_error_handler.dart';
import 'package:weather_app/services/app_exception.dart';
import 'package:weather_app/services/weather_service_config.dart';

class WeatherService {
  static const String _baseUrl = 'http://api.weatherapi.com/v1';

  Future<WeatherModel?> getWeather({required String cityName}) async {
    final WeatherModel? weather;
    http.Response? response;
    try {
      // TODO: Separate the data fetching logic into a new HttpClient class.
      // TODO: Move the parsing logic to a separate method.

      final Uri url = Uri.parse(
        '$_baseUrl/forecast.json?key=$apiKey&q=$cityName&days=5&aqi=no&alerts=no',
      );
      response = await http.get(url);
      if (response.statusCode != 200) {
        final AppException? exception =
            AppErrorHandler.handle(response: response);
        if (exception != null) {
          throw exception;
        }
      }
      weather = WeatherModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw AppErrorHandler.handle(exception: e)!;
    }

    return weather;
  }

  //This will return error message since the history api is not free.
  Future<WeatherModel?> getWeatherHistory({required String cityName}) async {
    final WeatherModel? weather;
    http.Response? response;
    try {
      final Uri url = Uri.parse(
        '$_baseUrl/history.json?key=$apiKey&q=$cityName&days=5&aqi=no&alerts=no&dt=2022-01-01',
      );
      // need client.
      response = await http.get(url);
      if (response.statusCode != 200) {
        final AppException? exception =
            AppErrorHandler.handle(response: response);
        if (exception != null) {
          throw exception;
        }
      }
      weather = WeatherModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw AppErrorHandler.handle(exception: e)!;
    }
    return weather;
  }
}

class _WeatherService {
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      //Todo this method is doing more than one job so it's violating the single responsibility principle, since it's responsible for
      // fetching the data and parsing it, so we need to separate the logic by creating http client which is responsible for requests only and return AppHttpResponse only then the parsing will be done her.
      String baseUrl = 'http://api.weatherapi.com/v1';
      String apiKey = '';
      Uri url = Uri.parse(
          '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=5&aqi=no&alerts=no');
      // need clinet.
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      weather = WeatherModel.fromJson(data);
    } catch (e) {
      // the user has no idea what is the problem we need to show a message to the user.
      print(e);
    }
    return weather;
  }
}
