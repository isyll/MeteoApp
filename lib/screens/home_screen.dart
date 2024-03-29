import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meteo_app/config/app_colors.dart';
import 'package:meteo_app/types/weather_data.dart';
import 'package:meteo_app/widgets/weather_forecast.dart';
import 'package:meteo_app/widgets/weather_today.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.city});

  final List<WeatherData> forecasts = [];
  final String city;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Container(
            color: AppColors.secondary,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [WeatherToday(city: city), WeatherForecast()],
        )
      ],
    );
  }
}
