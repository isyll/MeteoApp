import 'package:meteo_app/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app/config/weather_defaults.dart';

class ApiService {
  static const weatherUrl = '${Constants.apiUrl}/weather?APPID=${Constants.apiKey}';
  static const forecastUrl = '${Constants.apiUrl}/forecast?APPID=${Constants.apiKey}';

  static Future<http.Response> getDefaultWeatherData() {
    return getWeatherData(WeatherDefaults.country, WeatherDefaults.city);
  }

  static Future<http.Response> getDefaultForecastData() {
    return getForecastData(WeatherDefaults.country, WeatherDefaults.city);
  }

  static Future<http.Response> getWeatherData(String country, String city) {
    return http.get(Uri.parse('$weatherUrl&q=$city,$country'));
  }

  static Future<http.Response> getForecastData(String country, String city) {
    return http.get(Uri.parse('$forecastUrl&q=$city,$country'));
  }
}
