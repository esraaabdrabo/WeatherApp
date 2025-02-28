import 'package:flutter/material.dart';

enum WeatherState {
  sunny,
  partlyCloudy,
  cloudy,
  overcast,
  mist,
  patchyRainPossible,
  patchyLightRain,
  lightRain,
  moderateRainAtTimes,
  moderateRain,
  heavyRainAtTimes,
  heavyRain,
  lightFreezingRain,
  moderateOrHeavyRainShower,
  torrentialRainShower,
  patchyLightRainWithThunder,
  moderateOrHeavyRainWithThunder,
  moderateOrHeavySnowWithThunder,
  patchyLightSnowWithThunder,
  moderateOrHeavySnowShowers,
  lightSnowShowers,
  moderateOrHeavySleetShowers,
  lightSleetShowers,
  heavySnow,
  patchyHeavySnow,
  moderateSnow,
  patchyModerateSnow,
  lightSnow,
  patchyLightSnow,
  moderateOrHeavyShowersOfIcePellets,
  lightShowersOfIcePellets,
  icePellets,
  lightSleet,
  moderateOrHeavySleet,
  freezingDrizzle,
  lightDrizzle,
  patchyLightDrizzle,
  freezingFog,
  thunderyOutbreaksPossible,
  patchySleetPossible,
  unknown
}

extension WeatherStateExtension on WeatherState {
  MaterialColor get color {
    switch (this) {
      case WeatherState.sunny:
        return Colors.orange;
      case WeatherState.partlyCloudy:
      case WeatherState.cloudy:
        return Colors.blueGrey;
      case WeatherState.overcast:
      case WeatherState.mist:
        return Colors.deepPurple;
      case WeatherState.patchyRainPossible:
      case WeatherState.patchyLightRain:
      case WeatherState.lightRain:
      case WeatherState.moderateRainAtTimes:
      case WeatherState.moderateRain:
      case WeatherState.heavyRainAtTimes:
      case WeatherState.heavyRain:
      case WeatherState.lightFreezingRain:
      case WeatherState.moderateOrHeavyRainShower:
      case WeatherState.torrentialRainShower:
      case WeatherState.patchyLightRainWithThunder:
      case WeatherState.moderateOrHeavyRainWithThunder:
        return Colors.brown;
      case WeatherState.moderateOrHeavySnowWithThunder:
      case WeatherState.patchyLightSnowWithThunder:
      case WeatherState.moderateOrHeavySnowShowers:
      case WeatherState.lightSnowShowers:
      case WeatherState.moderateOrHeavySleetShowers:
      case WeatherState.lightSleetShowers:
      case WeatherState.heavySnow:
      case WeatherState.patchyHeavySnow:
      case WeatherState.moderateSnow:
      case WeatherState.patchyModerateSnow:
      case WeatherState.lightSnow:
      case WeatherState.patchyLightSnow:
        return Colors.grey;
      case WeatherState.moderateOrHeavyShowersOfIcePellets:
      case WeatherState.lightShowersOfIcePellets:
      case WeatherState.icePellets:
        return Colors.yellow;
      case WeatherState.lightSleet:
      case WeatherState.moderateOrHeavySleet:
      case WeatherState.freezingDrizzle:
      case WeatherState.lightDrizzle:
      case WeatherState.patchyLightDrizzle:
      case WeatherState.freezingFog:
      case WeatherState.thunderyOutbreaksPossible:
      case WeatherState.patchySleetPossible:
        return Colors.blue;
      case WeatherState.unknown:
        return Colors.red;
    }
  }

  static WeatherState fromString(String weatherStateName) {
    switch (weatherStateName) {
      case "Sunny":
        return WeatherState.sunny;
      case "Partly cloudy":
      case "Cloudy":
        return WeatherState.partlyCloudy;
      case "Overcast":
      case "Mist":
        return WeatherState.overcast;
      case "Patchy rain possible":
      case "Patchy light rain":
      case "Light rain":
      case "Moderate rain at times":
      case "Moderate rain":
      case "Heavy rain at times":
      case "Heavy rain":
      case "Light freezing rain":
      case "Moderate or heavy rain shower":
      case "Torrential rain shower":
      case "Patchy light rain with thunder":
      case "Moderate or heavy rain with thunder":
        return WeatherState.patchyRainPossible;
      case "Moderate or heavy snow with thunder":
      case "Patchy light snow with thunder":
      case "Moderate or heavy snow showers":
      case "Light snow showers":
      case "Moderate or heavy sleet showers":
      case "Light sleet showers":
      case "Heavy snow":
      case "Patchy heavy snow":
      case "Moderate snow":
      case "Patchy moderate snow":
      case "Light snow":
      case "Patchy light snow":
        return WeatherState.moderateOrHeavySnowWithThunder;
      case "Moderate or heavy showers of ice pellets":
      case "Light showers of ice pellets":
      case "Ice pellets":
        return WeatherState.moderateOrHeavyShowersOfIcePellets;
      case "Light sleet":
      case "Moderate or heavy sleet":
      case "Freezing drizzle":
      case "Light drizzle":
      case "Patchy light drizzle":
      case "Freezing fog":
      case "Thundery outbreaks possible":
      case "Patchy sleet possible":
        return WeatherState.lightSleet;
      default:
        return WeatherState.unknown;
    }
  }

  String get displayName {
    switch (this) {
      case WeatherState.sunny:
        return "Sunny";
      case WeatherState.partlyCloudy:
        return "Partly cloudy";
      case WeatherState.cloudy:
        return "Cloudy";
      case WeatherState.overcast:
        return "Overcast";
      case WeatherState.mist:
        return "Mist";
      case WeatherState.patchyRainPossible:
        return "Patchy rain possible";
      case WeatherState.patchyLightRain:
        return "Patchy light rain";
      case WeatherState.lightRain:
        return "Light rain";
      case WeatherState.moderateRainAtTimes:
        return "Moderate rain at times";
      case WeatherState.moderateRain:
        return "Moderate rain";
      case WeatherState.heavyRainAtTimes:
        return "Heavy rain at times";
      case WeatherState.heavyRain:
        return "Heavy rain";
      case WeatherState.lightFreezingRain:
        return "Light freezing rain";
      case WeatherState.moderateOrHeavyRainShower:
        return "Moderate or heavy rain shower";
      case WeatherState.torrentialRainShower:
        return "Torrential rain shower";
      case WeatherState.patchyLightRainWithThunder:
        return "Patchy light rain with thunder";
      case WeatherState.moderateOrHeavyRainWithThunder:
        return "Moderate or heavy rain with thunder";
      case WeatherState.moderateOrHeavySnowWithThunder:
        return "Moderate or heavy snow with thunder";
      case WeatherState.patchyLightSnowWithThunder:
        return "Patchy light snow with thunder";
      case WeatherState.moderateOrHeavySnowShowers:
        return "Moderate or heavy snow showers";
      case WeatherState.lightSnowShowers:
        return "Light snow showers";
      case WeatherState.moderateOrHeavySleetShowers:
        return "Moderate or heavy sleet showers";
      case WeatherState.lightSleetShowers:
        return "Light sleet showers";
      case WeatherState.heavySnow:
        return "Heavy snow";
      case WeatherState.patchyHeavySnow:
        return "Patchy heavy snow";
      case WeatherState.moderateSnow:
        return "Moderate snow";
      case WeatherState.patchyModerateSnow:
        return "Patchy moderate snow";
      case WeatherState.lightSnow:
        return "Light snow";
      case WeatherState.patchyLightSnow:
        return "Patchy light snow";
      case WeatherState.moderateOrHeavyShowersOfIcePellets:
        return "Moderate or heavy showers of ice pellets";
      case WeatherState.lightShowersOfIcePellets:
        return "Light showers of ice pellets";
      case WeatherState.icePellets:
        return "Ice pellets";
      case WeatherState.lightSleet:
        return "Light sleet";
      case WeatherState.moderateOrHeavySleet:
        return "Moderate or heavy sleet";
      case WeatherState.freezingDrizzle:
        return "Freezing drizzle";
      case WeatherState.lightDrizzle:
        return "Light drizzle";
      case WeatherState.patchyLightDrizzle:
        return "Patchy light drizzle";
      case WeatherState.freezingFog:
        return "Freezing fog";
      case WeatherState.thunderyOutbreaksPossible:
        return "Thundery outbreaks possible";
      case WeatherState.patchySleetPossible:
        return "Patchy sleet possible";
      case WeatherState.unknown:
        return "Unknown";
    }
  }
}
