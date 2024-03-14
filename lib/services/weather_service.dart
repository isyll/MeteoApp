import 'package:flutter/material.dart';
import 'package:meteo_app/enums/weather_code.dart';

class WeatherService {
  static Image getWeatherIcon(WeatherCode code, {double width = 140}) {
    final String pathName = 'assets/images/${code.name}.png';
    return Image.asset(pathName, width: width);
  }

//   Image fromString(String code) {
//     if (!WeatherCode.values.contains(code)) {
//       return;
//     }
//   }

  static String getWeatherLabel(WeatherCode code) {
    switch (code) {
      case WeatherCode.sunny:
        return 'Soleil';
      case WeatherCode.snowy:
        return 'Neigeux';
      case WeatherCode.rainy:
        return 'Pluvieux';
      case WeatherCode.cloud:
        return 'Nuageux';
      case WeatherCode.stormy:
        return 'Orage';
    }
  }

  static String temperature(int temperature) => '$temperature °C';

  static String windSpeed(int windSpeed) => '$windSpeed Km/h';

  static String chanceOfPrecipitations(int cop) => '$cop %';

  static String airHumidity(int airHumidity) => '$airHumidity %';
}
