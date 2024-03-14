import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/services/weather_service.dart';
import 'package:meteo_app/widgets/weather_info.dart';

class WeatherToday extends StatelessWidget {
  const WeatherToday({super.key});

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height / 2;
    const weatherInfo = WeatherInfo(
        country: 'Sénégal',
        city: 'Dakar',
        weatherCode: WeatherCode.sunny,
        temperature: 19);

    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      color: const Color(0xff4f5563),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.all(32.0),
              child: WeatherService.getWeatherIcon(WeatherCode.sunny)),
          const Padding(
            padding: EdgeInsets.all(32.0),
            child: weatherInfo,
          )
        ],
      ),
    );
  }
}
