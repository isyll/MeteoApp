import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meteo_app/config/weather_defaults.dart';
import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/services/api_service.dart';
import 'package:meteo_app/services/data_mapper.dart';
import 'package:meteo_app/services/weather_service.dart';
import 'package:meteo_app/types/weather_data.dart';
import 'package:meteo_app/widgets/weather_info.dart';

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
      var weatherInfo = WeatherInfo(
          country: WeatherDefaults.countryName,
          city: WeatherDefaults.city,
          weatherCode: _weatherData!.weatherCode,
          temperature: _weatherData!.weather.temperature);

      children = [
        Padding(
            padding: const EdgeInsets.all(32.0),
            child: WeatherService.getWeatherIcon(WeatherCode.sunny)),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: weatherInfo,
        )
      ];
    } else {
      fetchWeatherData();
    }

    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      color: const Color(0xff4f5563),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
