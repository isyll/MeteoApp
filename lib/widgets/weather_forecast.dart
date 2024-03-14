import 'package:flutter/material.dart';
import 'package:meteo_app/services/date_service.dart';
import 'package:meteo_app/services/weather_service.dart';
import 'package:meteo_app/types/weather_data.dart';
import 'package:intl/intl.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key, required this.forecasts});

  final List<WeatherData> forecasts; // Prévisions des prochains jours
  final TextStyle defaultTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto',
      decoration: TextDecoration.none);

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

    return Expanded(
        child: Container(
      decoration: decoration,
      child: Column(
        children: getForecastWidgets(),
      ),
    ));
  }

  List<Widget> getForecastWidgets() {
    return forecasts
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
                  style: defaultTextStyle,
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
                    style: defaultTextStyle,
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
                  style: defaultTextStyle,
                ),
              ],
            )
          ],
        )
      ]),
    );
  }
}
