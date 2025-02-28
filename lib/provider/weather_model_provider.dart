import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherData;

  String? cityName;
  set weatherData(WeatherModel? weather) {
    //Todo: the provider is responsible for updating the UI and managing the state, so here we need to manage the fetching logic and the error handling.
    _weatherData = weather;

    notifyListeners();
  }

  WeatherModel? get weatherData => _weatherData;
}
