import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_state.dart';

//Todo extend Equatable to make the model comparable and to make immutable.
class WeatherModel {
  // ignore: slash_for_doc_comments
  /**SOLID Principle: Open/Closed Principle (OCP)
Issue:
If variables are mutable, modifying an object’s state later in the program may require unnecessary changes to other parts of the code.
Link to OCP:
A class should be open for extension but closed for modification.
Using final enforces immutability, reducing the need to modify existing classes.
Solution:
If a variable never needs to change, marking it as final prevents unintended modifications.
This ensures that modifications to logic don’t require changing class internals.
 */
  final DateTime date;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final WeatherState state;
  final String icon;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.state,
      required this.icon});

  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];

    String localTime = data['location']['localtime'];
    //Todo encapsulate this formatting to make sure that every part in the app that will need to format the date will use the same format (consistency).
/**Why is this a violation?
The model should only store and represent data, not format it.
Date parsing and formatting should be handled in a separate helper class or in the UI layer.
If another part of the app needs a different date format, you would need to modify the model, breaking SRP.
Fix: Move Formatting to a Utility Class */
    DateFormat inputFormat = DateFormat('yyyy-MM-dd hh:mm');
    DateTime input = inputFormat.parse(localTime);
    String date = DateFormat('yyyy-MM-dd hh:mm').format(input);

    return WeatherModel(
        date: DateTime.parse(date),
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        state: WeatherStateExtension.fromString(jsonData['condition']['text']),
        icon: jsonData['condition']['icon']);
  }
  @override
  String toString() {
    return 'temp=$temp  minTemp=$minTemp maxTemp=$maxTemp';
  }
}

//Todo extend Equatable to make the model comparable and to make immutable.
class _WeatherModel {
  // ignore: slash_for_doc_comments
  /**SOLID Principle: Open/Closed Principle (OCP)
Issue:
If variables are mutable, modifying an object’s state later in the program may require unnecessary changes to other parts of the code.
Link to OCP:
A class should be open for extension but closed for modification.
Using final enforces immutability, reducing the need to modify existing classes.
Solution:
If a variable never needs to change, marking it as final prevents unintended modifications.
This ensures that modifications to logic don’t require changing class internals.
 */
  DateTime date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;
  String icon;

  _WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherStateName,
      required this.icon});

  factory _WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];

    String localtime = data['location']['localtime'];
    //Todo encapsulate this formatting to make sure that every part in the app that will need to format the date will use the same format (consistency).
/**Why is this a violation?
The model should only store and represent data, not format it.
Date parsing and formatting should be handled in a separate helper class or in the UI layer.
If another part of the app needs a different date format, you would need to modify the model, breaking SRP.
Fix: Move Formatting to a Utility Class */
    DateFormat inputFormat = DateFormat('yyyy-MM-dd hh:mm');
    DateTime input = inputFormat.parse(localtime);
    String datee = DateFormat('yyyy-MM-dd hh:mm').format(input);

    return _WeatherModel(
        date: DateTime.parse(datee),
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        weatherStateName: jsonData['condition']['text'],
        icon: jsonData['condition']['icon']);
  }
  @override
  String toString() {
    return 'temp=$temp  minTemp=$minTemp maxTemp=$maxTemp';
  }

  MaterialColor getColor() {
    //Todo we need to use enums here in order to manage the colors in a better way.
/**Why is this a violation?
If you add a new weather condition, you have to modify the existing code (violating OCP).
The model is not easily extendable.
String comparisons are error-prone (e.g., if "Patchy rain possible" is mistyped, the model might fail). */
    // since we already have huge number of states and by using the string comparison way we might face misspelling issues.
    if (weatherStateName == "Sunny") {
      // Todo we need to move this into UI since it's not a model responsibility to manage the colors.
/**Why is this a Violation?
SRP Violation (Single Responsibility Principle)

The model (WeatherModel) should only represent weather data.
Managing UI-related concerns (like colors) adds an extra responsibility to the model.
If the way we assign colors changes, we must modify the model instead of updating the UI layer.
Wrong Dependency Flow

Models should not depend on UI elements (MaterialColor in this case).
If the model needs to be used in another layer (e.g., API service, local database, unit tests), it should not be tied to UI-related decisions.
Maintainability Issue

Suppose a designer updates the colors in the app.
You would have to modify the model instead of just updating the UI.
This increases coupling between the UI and the business logic.
 */
      //Todo we need to encapsulate the colors into AppColors class since any value can be changed in any business level (encapsulation and maintainability).
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
