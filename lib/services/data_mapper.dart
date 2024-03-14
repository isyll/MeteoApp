import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/types/weather.dart';
import 'package:meteo_app/types/weather_data.dart';

class DataMapper {
  static WeatherData getWeatherData(Map<String, dynamic> json) {
    final double temp = json['main']['temp'];
    final double humidity = json['main']['temp'];
    final double windSpeed = json['wind']['speed'];
    const double precipitations = 14.0;
    final int weatherId = json['weather'][0]['id'];
    final int timestamp = json['dt'];
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    final weather = Weather(
        temperature: convertKelvinToCelsius(temp).toInt(),
        windSpeed: windSpeed.toInt(),
        chanceOfPrecipitations: precipitations.toInt(),
        airHumidity: humidity.toInt());

    return WeatherData(
        weather: weather,
        weatherCode: getWeatherCode(weatherId),
        weatherDate: date);
  }

  static double convertKelvinToCelsius(double temperatureKelvin) =>
      temperatureKelvin - 273.15;

  static WeatherCode getWeatherCode(int weatherId) {
    if (weatherId >= 200 && weatherId < 300) {
      return WeatherCode.stormy;
    } else if (weatherId >= 300 && weatherId < 600) {
      return WeatherCode.rainy;
    } else if (weatherId >= 600 && weatherId < 700) {
      return WeatherCode.snowy;
    } else if (weatherId == 800) {
      return WeatherCode.sunny;
    }
//   else if (weatherId > 800 && weatherId < 900)
    return WeatherCode.cloud;
  }
}
