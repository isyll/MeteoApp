import 'package:meteo_app/services/data_mapper.dart';
import 'package:meteo_app/services/weather_service.dart';

class Weather {
  final int temperature;
  final int windSpeed;
  final int airHumidity;

  final int minTemp;
  final int maxTemp;

  DateTime sunset = DateTime.now();
  DateTime sunrise = DateTime.now();

  Weather(
      {required this.temperature,
      required this.windSpeed,
      required this.airHumidity,
      this.minTemp = 0,
      this.maxTemp = 0});

  String tempsToStr() {
    final convertedMin =
        DataMapper.convertKelvinToCelsius(minTemp.toDouble()).toInt();
    final convertedMax =
        DataMapper.convertKelvinToCelsius(maxTemp.toDouble()).toInt();

    return '$convertedMin-$convertedMax ${WeatherService.tempIcon}';
  }
}
