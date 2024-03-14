import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/types/weather.dart';

class WeatherData {
  final DateTime weatherDate;
  final WeatherCode weatherCode;
  final Weather weather;

  const WeatherData(
      {required this.weather,
      required this.weatherCode,
      required this.weatherDate});
}
