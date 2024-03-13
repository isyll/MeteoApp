import 'package:flutter/material.dart';
import 'package:meteo_app/enums/weather_code.dart';

class WeatherService {
  Image getWeatherIcon(WeatherCode code) {
    final String pathName = 'assets/images/${code.name}.png';
    return Image.asset(pathName, width: 140);
  }

//   Image fromString(String code) {
//     if (!WeatherCode.values.contains(code)) {
//       return;
//     }
//   }

  String getWeatherLabel(WeatherCode code) {
    switch (code) {
      case WeatherCode.sunny:
        return 'Soleil';
      case WeatherCode.snowy:
        return 'Neigeux';
      case WeatherCode.rainy:
        return 'Pluvieux';
      case WeatherCode.cloud:
        return 'Nuageux';
    }
  }
}
