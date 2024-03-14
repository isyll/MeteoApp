import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meteo_app/services/api_service.dart';
import 'package:meteo_app/services/data_mapper.dart';
import 'package:meteo_app/services/date_service.dart';
import 'package:meteo_app/services/weather_service.dart';
import 'package:meteo_app/types/weather_data.dart';
import 'package:intl/intl.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  List<WeatherData> _forecasts = [];
  bool _isLoading = false;

  final TextStyle _defaultTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto',
      decoration: TextDecoration.none);

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
        throw Exception('Impossible de récupérer les prévissions météo');
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
    const BoxDecoration decoration = BoxDecoration(
      color: Color(0xff3c4252),
      border: Border(
        top: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );

    List<Widget> children = [];

    if (_isLoading) {
      children = [const CircularProgressIndicator()];
    } else if (_forecasts.isNotEmpty) {
      children = getForecastWidgets();
    } else {
      fetchForecastData();
    }

    return Expanded(
        child: Container(
      decoration: decoration,
      child: Column(
        children: children,
      ),
    ));
  }

  List<Widget> getForecastWidgets() {
    return _forecasts
        .map((f) => Row(children: [_weatherSummary(f), _weatherDetails(f)]))
        .toList();
  }

  Widget _weatherSummary(WeatherData weatherData) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(right: BorderSide(color: Colors.white, width: 1))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateService.weekday(weatherData.weatherDate.weekday),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                      decoration: TextDecoration.none),
                ),
                Text(
                  DateFormat('HH:mm').format(weatherData.weatherDate),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                      decoration: TextDecoration.none),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: WeatherService.getWeatherIcon(weatherData.weatherCode,
                    width: 90.0))
          ]),
        ));
  }

  Widget _weatherDetails(WeatherData weatherData) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(WeatherService.getWeatherLabel(weatherData.weatherCode),
            style: const TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
                decoration: TextDecoration.none)),
        Text(
          WeatherService.temperature(weatherData.weather.temperature),
          style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(children: [
                Image.asset(
                  'assets/images/wind_speed.png',
                  width: 22,
                ),
                Text(
                  WeatherService.windSpeed(weatherData.weather.windSpeed),
                  style: _defaultTextStyle,
                ),
              ]),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(children: [
                  Image.asset(
                    'assets/images/humidity.png',
                    width: 22,
                  ),
                  Text(
                    WeatherService.airHumidity(weatherData.weather.airHumidity),
                    style: _defaultTextStyle,
                  )
                ])),
            Column(
              children: [
                Image.asset(
                  'assets/images/precipitations.png',
                  width: 22,
                ),
                Text(
                  WeatherService.chanceOfPrecipitations(
                      weatherData.weather.chanceOfPrecipitations),
                  style: _defaultTextStyle,
                ),
              ],
            )
          ],
        )
      ]),
    );
  }
}
