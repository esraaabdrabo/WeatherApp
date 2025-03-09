import 'package:flutter/material.dart';
import 'package:weather_app/app_colors.dart';
import 'package:weather_app/model/weather_strings.dart';

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
        return AppColors.orange;
      case WeatherState.partlyCloudy:
      case WeatherState.cloudy:
        return AppColors.blueGrey;
      case WeatherState.overcast:
      case WeatherState.mist:
        return AppColors.deepPurple;
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
        return AppColors.brown;
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
        return AppColors.grey;
      case WeatherState.moderateOrHeavyShowersOfIcePellets:
      case WeatherState.lightShowersOfIcePellets:
      case WeatherState.icePellets:
        return AppColors.yellow;
      case WeatherState.lightSleet:
      case WeatherState.moderateOrHeavySleet:
      case WeatherState.freezingDrizzle:
      case WeatherState.lightDrizzle:
      case WeatherState.patchyLightDrizzle:
      case WeatherState.freezingFog:
      case WeatherState.thunderyOutbreaksPossible:
      case WeatherState.patchySleetPossible:
        return AppColors.blue;
      case WeatherState.unknown:
        return AppColors.red;
    }
  }

  static WeatherState fromString(String weatherStateName) {
    switch (weatherStateName) {
      case WeatherStrings.sunny:
        return WeatherState.sunny;
      case WeatherStrings.partlyCloudy:
      case WeatherStrings.cloudy:
        return WeatherState.partlyCloudy;
      case WeatherStrings.overcast:
      case WeatherStrings.mist:
        return WeatherState.overcast;
      case WeatherStrings.patchyRainPossible:
      case WeatherStrings.patchyLightRain:
      case WeatherStrings.lightRain:
      case WeatherStrings.moderateRainAtTimes:
      case WeatherStrings.moderateRain:
      case WeatherStrings.heavyRainAtTimes:
      case WeatherStrings.heavyRain:
      case WeatherStrings.lightFreezingRain:
      case WeatherStrings.moderateOrHeavyRainShower:
      case WeatherStrings.torrentialRainShower:
      case WeatherStrings.patchyLightRainWithThunder:
      case WeatherStrings.moderateOrHeavyRainWithThunder:
        return WeatherState.patchyRainPossible;
      case WeatherStrings.moderateOrHeavySnowWithThunder:
      case WeatherStrings.patchyLightSnowWithThunder:
      case WeatherStrings.moderateOrHeavySnowShowers:
      case WeatherStrings.lightSnowShowers:
      case WeatherStrings.moderateOrHeavySleetShowers:
      case WeatherStrings.lightSleetShowers:
      case WeatherStrings.heavySnow:
      case WeatherStrings.patchyHeavySnow:
      case WeatherStrings.moderateSnow:
      case WeatherStrings.patchyModerateSnow:
      case WeatherStrings.lightSnow:
      case WeatherStrings.patchyLightSnow:
        return WeatherState.moderateOrHeavySnowWithThunder;
      case WeatherStrings.moderateOrHeavyShowersOfIcePellets:
      case WeatherStrings.lightShowersOfIcePellets:
      case WeatherStrings.icePellets:
        return WeatherState.moderateOrHeavyShowersOfIcePellets;
      case WeatherStrings.lightSleet:
      case WeatherStrings.moderateOrHeavySleet:
      case WeatherStrings.freezingDrizzle:
      case WeatherStrings.lightDrizzle:
      case WeatherStrings.patchyLightDrizzle:
      case WeatherStrings.freezingFog:
      case WeatherStrings.thunderyOutbreaksPossible:
      case WeatherStrings.patchySleetPossible:
        return WeatherState.lightSleet;
      default:
        return WeatherState.unknown;
    }
  }

  String get displayName {
    switch (this) {
      case WeatherState.sunny:
        return WeatherStrings.sunny;
      case WeatherState.partlyCloudy:
        return WeatherStrings.partlyCloudy;
      case WeatherState.cloudy:
        return WeatherStrings.cloudy;
      case WeatherState.overcast:
        return WeatherStrings.overcast;
      case WeatherState.mist:
        return WeatherStrings.mist;
      case WeatherState.patchyRainPossible:
        return WeatherStrings.patchyRainPossible;
      case WeatherState.patchyLightRain:
        return WeatherStrings.patchyLightRain;
      case WeatherState.lightRain:
        return WeatherStrings.lightRain;
      case WeatherState.moderateRainAtTimes:
        return WeatherStrings.moderateRainAtTimes;
      case WeatherState.moderateRain:
        return WeatherStrings.moderateRain;
      case WeatherState.heavyRainAtTimes:
        return WeatherStrings.heavyRainAtTimes;
      case WeatherState.heavyRain:
        return WeatherStrings.heavyRain;
      case WeatherState.lightFreezingRain:
        return WeatherStrings.lightFreezingRain;
      case WeatherState.moderateOrHeavyRainShower:
        return WeatherStrings.moderateOrHeavyRainShower;
      case WeatherState.torrentialRainShower:
        return WeatherStrings.torrentialRainShower;
      case WeatherState.patchyLightRainWithThunder:
        return WeatherStrings.patchyLightRainWithThunder;
      case WeatherState.moderateOrHeavyRainWithThunder:
        return WeatherStrings.moderateOrHeavyRainWithThunder;
      case WeatherState.moderateOrHeavySnowWithThunder:
        return WeatherStrings.moderateOrHeavySnowWithThunder;
      case WeatherState.patchyLightSnowWithThunder:
        return WeatherStrings.patchyLightSnowWithThunder;
      case WeatherState.moderateOrHeavySnowShowers:
        return WeatherStrings.moderateOrHeavySnowShowers;
      case WeatherState.lightSnowShowers:
        return WeatherStrings.lightSnowShowers;
      case WeatherState.moderateOrHeavySleetShowers:
        return WeatherStrings.moderateOrHeavySleetShowers;
      case WeatherState.lightSleetShowers:
        return WeatherStrings.lightSleetShowers;
      case WeatherState.heavySnow:
        return WeatherStrings.heavySnow;
      case WeatherState.patchyHeavySnow:
        return WeatherStrings.patchyHeavySnow;
      case WeatherState.moderateSnow:
        return WeatherStrings.moderateSnow;
      case WeatherState.patchyModerateSnow:
        return WeatherStrings.patchyModerateSnow;
      case WeatherState.lightSnow:
        return WeatherStrings.lightSnow;
      case WeatherState.patchyLightSnow:
        return WeatherStrings.patchyLightSnow;
      case WeatherState.moderateOrHeavyShowersOfIcePellets:
        return WeatherStrings.moderateOrHeavyShowersOfIcePellets;
      case WeatherState.lightShowersOfIcePellets:
        return WeatherStrings.lightShowersOfIcePellets;
      case WeatherState.icePellets:
        return WeatherStrings.icePellets;
      case WeatherState.lightSleet:
        return WeatherStrings.lightSleet;
      case WeatherState.moderateOrHeavySleet:
        return WeatherStrings.moderateOrHeavySleet;
      case WeatherState.freezingDrizzle:
        return WeatherStrings.freezingDrizzle;
      case WeatherState.lightDrizzle:
        return WeatherStrings.lightDrizzle;
      case WeatherState.patchyLightDrizzle:
        return WeatherStrings.patchyLightDrizzle;
      case WeatherState.freezingFog:
        return WeatherStrings.freezingFog;
      case WeatherState.thunderyOutbreaksPossible:
        return WeatherStrings.thunderyOutbreaksPossible;
      case WeatherState.patchySleetPossible:
        return WeatherStrings.patchySleetPossible;
      case WeatherState.unknown:
        return WeatherStrings.unknown;
    }
  }
}
