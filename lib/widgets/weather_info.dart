import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/services/weather_service.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo(
      {super.key,
      required this.country,
      required this.city,
      required this.weatherCode,
      required this.temperature});

  final String country;
  final String city;
  final WeatherCode weatherCode;
  final int temperature;

  final TextStyle defaultTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto',
      decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    final weatherLabel = WeatherService.getWeatherLabel(weatherCode);
    return Align(
        alignment: Alignment.topLeft,
        child: Column(children: [
          Text(country,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.none)),
          Text(
            city,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 34.0,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
                decoration: TextDecoration.none),
          ),
          Row(
            children: [
              Text(
                weatherLabel,
                style: defaultTextStyle,
              ),
              const Text(
                ' ',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                WeatherService.temperature(temperature),
                style: defaultTextStyle,
              ),
            ],
          )
        ]));
  }
}
