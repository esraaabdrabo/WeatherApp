import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      //Todo this method is doing more than one job so it's violating the single responsibility principle, since it's responsible for
      // fetching the data and parsing it, so we need to separate the logic by creating http client which is responsible for requests only and return AppHttpResponse only then the parsing will be done her.
      String baseUrl = 'http://api.weatherapi.com/v1';
      String apiKey = 'c9f3945c6eae4ec188b61511220709';
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
