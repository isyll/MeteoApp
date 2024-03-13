import 'package:flutter/material.dart';
import 'package:meteo_app/widgets/weather_today.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [WeatherToday(), const Center(child: Text('adinedein'))],
    );
  }
}
