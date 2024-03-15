import 'package:meteo_app/config/weather_defaults.dart';
import 'package:meteo_app/enums/weather_code.dart';
import 'package:meteo_app/types/weather.dart';
import 'package:meteo_app/types/weather_data.dart';

class DataMapper {
  static WeatherData getWeatherData(Map<String, dynamic> json) {
    final double temp = json['main']['temp'] as double;
    final double minTemp = json['main']['temp_min'];
    final double maxTemp = json['main']['temp_max'];
    final double humidity = json['main']['temp'] as double;
    final double windSpeed = json['wind']['speed'];
    final int weatherId = json['weather'][0]['id'];
    final DateTime date = millisecondsToDate(json['dt']);

    DateTime sunrise = DateTime.now();
    DateTime sunset = DateTime.now();
    if (keyExists(json['sys'], 'sunrise')) {
      sunrise = millisecondsToDate(json['sys']['sunrise']);
    }
    if (keyExists(json['sys'], 'sunset')) {
      sunset = millisecondsToDate(json['sys']['sunset']);
    }

    final weather = Weather(
        temperature: convertKelvinToCelsius(temp).toInt(),
        windSpeed: windSpeed.toInt(),
        airHumidity: humidity.toInt(),
        minTemp: minTemp.toInt(),
        maxTemp: maxTemp.toInt());

    weather.sunrise = sunrise;
    weather.sunrise = sunset;

    return WeatherData(
        weather: weather,
        weatherCode: getWeatherCode(weatherId),
        weatherDate: date);
  }

  static bool keyExists(dynamic json, String key) {
    return json != null && json is Map && json.containsKey(key);
  }

  static DateTime millisecondsToDate(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  static List<WeatherData> getForecastData(Map<String, dynamic> json) {
    final List<dynamic> data = json['list'];
    final List<WeatherData> result = [];
    for (var i = 0; i < WeatherDefaults.lastDaysNumber; i++) {
      result.add(getWeatherData(data[i]));
    }
    return result;
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
