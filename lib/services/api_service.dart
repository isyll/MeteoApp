import 'package:meteo_app/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app/config/weather_defaults.dart';

class ApiService {
  static get url => '${Constants.apiUrl}?APPID=${Constants.apiKey}';

  Future<dynamic> getDefaultWeatherData() {
    return getWeatherData(WeatherDefaults.country, WeatherDefaults.city);
  }

  Future<dynamic> getWeatherData(String country, String city) {
    return http.get(url + '&$city,$country');
  }
}
