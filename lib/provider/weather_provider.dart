import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherData;

  String? cityName;
  set weatherData(WeatherModel? weather) {
    //Todo: the provider is responsible for updating the UI and managing the state, so here we need to manage the fetching logic and the error handling.
    _weatherData = weather;

    notifyListeners();
  }

  Future<WeatherModel?> getWeather({required String cityName}) async {
    //Todo need to use singleton pattern here instead of creating an instance every time we need to get the weather data.
    final WeatherService weatherService = WeatherService();
    final WeatherModel? result =
        await weatherService.getWeather(cityName: cityName);
    _weatherData = result;
    cityName = cityName;
    return _weatherData;
  }

  WeatherModel? get weatherData => _weatherData;
}
