import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meteo_app/services/api_service.dart';
import 'package:meteo_app/services/data_mapper.dart';
import 'package:meteo_app/services/date_service.dart';
import 'package:meteo_app/services/weather_service.dart';
import 'package:meteo_app/types/weather_data.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  List<WeatherData> _forecasts = [];
  bool _isLoading = false;

  Future<void> fetchForecastData() async {
    setState(() {
      _isLoading = true;
      _forecasts = [];
    });

    try {
      final response = await ApiService.getDefaultForecastData();

      if (response.statusCode == 200) {
        setState(() {
          final data = json.decode(response.body);
          _forecasts = DataMapper.getForecastData(data);
        });
      } else {
        throw Exception('Impossible de récupérer les prévisions météo');
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
    } else if (_forecasts.isNotEmpty) {
      children = getForecastWidgets();
    } else {
      fetchForecastData();
    }

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  List<Widget> getForecastWidgets() {
    return _forecasts
        .map((f) => Row(children: [_ForecastItem(weatherData: f)]))
        .toList();
  }
}

class _ForecastItem extends StatelessWidget {
  const _ForecastItem({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    const spacing = SizedBox(height: 10);

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 130, 130, 130), width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                const SizedBox(height: 6),
                Text(
                  DateService.weekday(weatherData.weatherDate.weekday),
                  style: const TextStyle(fontSize: 16),
                ),
                spacing,
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: WeatherService.getWeatherIcon(
                        weatherData.weatherCode,
                        width: 52.0)),
                spacing,
                Text(weatherData.weather.tempsToStr()),
                spacing,
              ],
            )));
  }
}
