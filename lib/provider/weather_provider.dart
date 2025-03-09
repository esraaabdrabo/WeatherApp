import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/app_exception.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/services/weather_service_queries.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService weatherService = WeatherService.instance;

  WeatherModel? _weatherData;

  String? cityName;
  String? errorMessage;
  bool isLoading = false;
  set weatherData(WeatherModel? weather) {
    //Todo: the provider is responsible for updating the UI and managing the state, so here we need to manage the fetching logic and the error handling.
    _weatherData = weather;

    notifyListeners();
  }

  Future<WeatherModel?> getWeather({required String name}) async {
    //Todo need to use singleton pattern here instead of creating an instance every time we need to get the weather data.
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    try {
      final WeatherModel? result = await weatherService.getWeather(
          quires: WeatherServiceQueries(cityName: name));
      _weatherData = result;
      cityName = name;
      errorMessage = null;
    } on AppException catch (e) {
      errorMessage = e.message;
    }
    isLoading = false;
    notifyListeners();
    return _weatherData;
  }

  WeatherModel? get weatherData => _weatherData;
}
