import 'package:meteo_app/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app/config/weather_defaults.dart';

class ApiService {
  static get url => '${Constants.apiUrl}?APPID=${Constants.apiKey}';

  static Future<http.Response> getDefaultWeatherData() {
    return getWeatherData(WeatherDefaults.country, WeatherDefaults.city);
  }

  static Future<http.Response> getWeatherData(String country, String city) {
    return http.get(Uri.parse(url + '&q=$city,$country'));
  }
}
