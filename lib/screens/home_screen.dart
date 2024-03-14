import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meteo_app/config/app_colors.dart';
import 'package:meteo_app/types/weather_data.dart';
import 'package:meteo_app/widgets/weather_forecast.dart';
import 'package:meteo_app/widgets/weather_today.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<WeatherData> forecasts = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Container(
            color: AppColors.secondary,
          ),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [WeatherToday()],
        )
      ],
    );
  }
}
