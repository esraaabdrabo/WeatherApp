// ignore_for_file: slash_for_doc_comments

import 'package:weather_app/services/weather_service_config.dart';

class WeatherServiceQueries {
  final String cityName;

  const WeatherServiceQueries({
    required this.cityName,
  });

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'apiKey': apiKey,
      'days': '5',
      'aqi': 'no',
      'alerts': 'no',
    };
  }
}
