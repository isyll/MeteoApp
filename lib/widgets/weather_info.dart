import 'package:flutter/material.dart';
import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/services/weather_service.dart';

class WeatherInfo extends StatelessWidget {
  WeatherInfo(
      {super.key,
      required this.country,
      required this.city,
      required this.weatherCode,
      required this.temperature});

  final String country;
  final String city;
  final WeatherCode weatherCode;
  final int temperature;

  final WeatherService weatherService = WeatherService();

  final TextStyle defaultTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 1.5,
      fontFamily: 'Roboto',
      decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    final weatherLabel = weatherService.getWeatherLabel(weatherCode);
    return Column(children: [
      Text(
        country,
        style: defaultTextStyle,
      ),
      Text(
        city,
        style: defaultTextStyle,
      ),
      Text(
        weatherLabel,
        style: defaultTextStyle,
      ),
      Text(
        temperature.toString(),
        style: defaultTextStyle,
      )
    ]);
  }
}
