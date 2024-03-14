import 'package:flutter/material.dart';
import 'package:meteo_app/enums/weather_code.dart';

class WeatherService {
  static const tempIcon = '°';

  static Image getWeatherIcon(WeatherCode code, {double width = 140}) {
    final String pathName = 'assets/images/${code.name}.png';
    return Image.asset(pathName, width: width);
  }

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

  static String temperature(int temperature) => '$temperature $tempIcon';

  static String windSpeed(int windSpeed) => '$windSpeed kmh';

  static String airHumidity(int airHumidity) => '$airHumidity %';
}
