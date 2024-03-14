import 'package:flutter/material.dart';
import 'package:meteo_app/services/date_service.dart';
import 'package:meteo_app/services/weather_service.dart';
import 'package:meteo_app/types/weather_data.dart';
import 'package:intl/intl.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key, required this.forecasts});

  final List<WeatherData> forecasts; // Prévision pour les prochains jours
  final TextStyle defaultTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14.0,
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
    return forecasts.map((f) {
      return Row(children: [
        Column(
          children: [
            Text(
              DateService.weekday(f.weatherDate.weekday),
              style: defaultTextStyle,
            ),
            Text(
              DateFormat('HH:mm').format(f.weatherDate),
              style: defaultTextStyle,
            ),
          ],
        ),
        WeatherService.getWeatherIcon(f.weatherCode, width: 84.0),
        const VerticalDivider(
          color: Colors.white,
          thickness: 2,
          width: 20,
          indent: 10,
          endIndent: 10,
        ),
        Text(
          WeatherService.getWeatherLabel(f.weatherCode),
          style: defaultTextStyle,
        ),
        Text(
          WeatherService.temperature(f.weather.temperature),
          style: defaultTextStyle,
        ),
        Row(
          children: [
            Text(
              WeatherService.windSpeed(f.weather.windSpeed),
              style: defaultTextStyle,
            ),
            Text(
              WeatherService.airHumidity(f.weather.airHumidity),
              style: defaultTextStyle,
            ),
            Text(
              WeatherService.chanceOfPrecipitations(
                  f.weather.chanceOfPrecipitations),
              style: defaultTextStyle,
            ),
          ],
        )
      ]);
    }).toList();
  }
}
