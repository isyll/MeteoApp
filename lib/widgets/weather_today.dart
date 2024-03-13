import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/services/weather_service.dart';
import 'package:meteo_app/widgets/weather_info.dart';

class WeatherToday extends StatelessWidget {
  WeatherToday({super.key});

  final WeatherService weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height / 2;
    final weatherInfo = WeatherInfo(
        country: 'Sénégal',
        city: 'Dakar',
        weatherCode: WeatherCode.sunny,
        temperature: 19);

    return Container(
      color: const Color.fromARGB(161, 102, 111, 210),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.all(43.0),
              child: weatherService.getWeatherIcon(WeatherCode.sunny)),
          Padding(
            padding: const EdgeInsets.all(43.0),
            child: weatherInfo,
          )
        ],
      ),
    );
  }
}
