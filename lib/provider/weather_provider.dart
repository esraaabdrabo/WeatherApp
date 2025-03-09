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

  Future<WeatherModel?> getWeather({required String name}) async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    try {
      final WeatherModel? result = await weatherService.getWeather(
        quires: WeatherServiceQueries(cityName: name),
      );
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
