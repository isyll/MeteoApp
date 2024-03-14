import 'package:flutter/material.dart';
import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/types/weather.dart';
import 'package:meteo_app/types/weather_data.dart';
import 'package:meteo_app/widgets/weather_forecast.dart';
import 'package:meteo_app/widgets/weather_today.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<WeatherData> forecasts = [];

  @override
  Widget build(BuildContext context) {
    loadForecasts();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [const WeatherToday(), WeatherForecast(forecasts: forecasts)],
    );
  }

  void loadForecasts() {
    for (var i = 0; i < 5; i++) {
      const Weather weather = Weather(
          airHumidity: 5,
          temperature: 34,
          chanceOfPrecipitations: 13,
          windSpeed: 15);

      forecasts.add(WeatherData(
          weather: weather,
          weatherCode: WeatherCode.snowy,
          weatherDate: DateTime.now()));
    }
  }
}
