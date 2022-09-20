import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;
  String icon;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherStateName,
      required this.icon});

  factory WeatherModel.fromJson(dynamic data) {
    var jsondata = data['forecast']['forecastday'][0]['day'];

    String localtime = data['location']['localtime'];
    DateFormat inputFormat = DateFormat('yyyy-MM-dd hh:mm');
    DateTime input = inputFormat.parse(localtime);
    String datee = DateFormat('yyyy-MM-dd hh:mm').format(input);

    return WeatherModel(
        date: DateTime.parse(datee),
        temp: jsondata['avgtemp_c'],
        maxTemp: jsondata['maxtemp_c'],
        minTemp: jsondata['mintemp_c'],
        weatherStateName: jsondata['condition']['text'],
        icon: jsondata['condition']['icon']);
  }
  @override
  String toString() {
    return 'temp=$temp  minTemp=$minTemp maxTemp=$maxTemp';
  }

  MaterialColor getColor() {
    if (weatherStateName == "Sunny") {
      return Colors.orange;
    } else if (weatherStateName == "Partly cloudy" ||
        weatherStateName == "Cloudy") {
      return Colors.blueGrey;
    } else if (weatherStateName == "Overcast" || weatherStateName == "Mist") {
      return Colors.deepPurple;
    } else if (weatherStateName == "Patchy rain possible" ||
        weatherStateName == "Patchy light rain" ||
        weatherStateName == "Light rain" ||
        weatherStateName == "Moderate rain at times" ||
        weatherStateName == "Moderate rain at times" ||
        weatherStateName == "Moderate rain" ||
        weatherStateName == "Heavy rain at times" ||
        weatherStateName == "Heavy rain" ||
        weatherStateName == "Light freezing rain" ||
        weatherStateName == "Moderate or heavy rain shower" ||
        weatherStateName == "Torrential rain shower" ||
        weatherStateName == "Patchy light rain with thunder" ||
        weatherStateName == "Moderate or heavy rain with thunder") {
      return Colors.brown;
    } else if (weatherStateName == "Moderate or heavy snow with thunder" ||
        weatherStateName == "Patchy light snow with thunder" ||
        weatherStateName == "Moderate or heavy snow showers" ||
        weatherStateName == "Light snow showers" ||
        weatherStateName == "Moderate or heavy sleet showers" ||
        weatherStateName == "Light sleet showers" ||
        weatherStateName == "Heavy snow" ||
        weatherStateName == "Patchy heavy snow" ||
        weatherStateName == "Moderate snow" ||
        weatherStateName == "Patchy moderate snow" ||
        weatherStateName == "Light snow" ||
        weatherStateName == "Patchy light snow") {
      return Colors.grey;
    } else if (weatherStateName == "Moderate or heavy showers of ice pellets" ||
        weatherStateName == "Light showers of ice pellets" ||
        weatherStateName == "Ice pellets") {
      return Colors.yellow;
    } else if (weatherStateName == "Light sleet" ||
        weatherStateName == "Moderate or heavy sleet" ||
        weatherStateName == "Freezing drizzle" ||
        weatherStateName == "Light drizzle" ||
        weatherStateName == "Patchy light drizzle" ||
        weatherStateName == "Freezing fog" ||
        weatherStateName == "Thundery outbreaks possible" ||
        weatherStateName == "Patchy sleet possible") {
      return Colors.blue;
    } else {
      return Colors.orange;
    }
  }
}
