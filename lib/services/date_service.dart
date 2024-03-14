import 'package:intl/intl.dart';
import 'package:meteo_app/utils/string.dart';

class DateService {
  static String weekday(int day) {
    switch (day) {
      case 1:
        return 'Lundi';
      case 2:
        return 'Mardi';
      case 3:
        return 'Mercredi';
      case 4:
        return 'Jeudi';
      case 5:
        return 'Vendredi';
      case 6:
        return 'Samedi';
      case 7:
        return 'Dimanche';
      default:
        return 'unknown';
    }
  }

  static String formatDate(DateTime date) {
    return StringUtils.capitalize(
        DateFormat('EEEE, d MMMM', 'fr_FR').format(date));
  }

  static String formatHourMinutes(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }
}
