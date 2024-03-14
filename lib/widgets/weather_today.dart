import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meteo_app/config/app_colors.dart';
import 'package:meteo_app/config/theme_config.dart';
import 'package:meteo_app/config/weather_defaults.dart';
import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/services/api_service.dart';
import 'package:meteo_app/services/data_mapper.dart';
import 'package:meteo_app/services/date_service.dart';
import 'package:meteo_app/services/weather_service.dart';
import 'package:meteo_app/types/weather_data.dart';

class WeatherToday extends StatefulWidget {
  const WeatherToday({super.key});

  @override
  WeatherTodayState createState() => WeatherTodayState();
}

class WeatherTodayState extends State<WeatherToday> {
  WeatherData? _weatherData;
  bool _isLoading = false;

  Future<void> fetchWeatherData() async {
    setState(() {
      _weatherData = null;
      _isLoading = true;
    });
    try {
      final response = await ApiService.getDefaultWeatherData();
      if (response.statusCode == 200) {
        setState(() {
          final data = json.decode(response.body);
          _weatherData = DataMapper.getWeatherData(data);
        });
      } else {
        throw Exception('Impossible de recupérer les données météo');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error $error');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (_isLoading) {
      children = [const CircularProgressIndicator()];
    } else if (_weatherData != null) {
      final weatherInfo = _WeatherInfo(
        country: WeatherDefaults.countryName,
        city: WeatherDefaults.city,
        weatherCode: _weatherData!.weatherCode,
        temperature: _weatherData!.weather.temperature,
        date: _weatherData!.weatherDate,
      );

      children = [
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 32, left: 32),
          child: weatherInfo,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 28, bottom: 24),
            child:
                WeatherService.getWeatherIcon(WeatherCode.sunny, width: 160)),
      ];
    } else {
      fetchWeatherData();
    }

    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      color: AppColors.primary,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
          Column(
            children: [
              Text(
                WeatherService.temperature(_weatherData!.weather.temperature),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.normal,
                    fontFamily: ThemeConfig.fontFamily,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(height: 12),
              Text(
                WeatherService.getWeatherLabel(_weatherData!.weatherCode),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: ThemeConfig.fontFamily,
                    decoration: TextDecoration.none),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _WeatherInfo extends StatelessWidget {
  const _WeatherInfo(
      {required this.country,
      required this.city,
      required this.weatherCode,
      required this.temperature,
      required this.date});

  final String country;
  final String city;
  final WeatherCode weatherCode;
  final int temperature;
  final DateTime date;

  final TextStyle defaultTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 22.0,
      fontWeight: FontWeight.normal,
      fontFamily: ThemeConfig.fontFamily,
      decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '$city, $country',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.normal,
                fontFamily: ThemeConfig.fontFamily,
                decoration: TextDecoration.none),
          ),
          Text(
            DateService.formatDate(date),
            style: defaultTextStyle,
          )
        ]));
  }
}
