import 'package:flutter/material.dart';
import 'package:meteo_app/config/theme_config.dart';
import 'package:meteo_app/screens/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Application Météo',
        theme: ThemeConfig.appTheme,
        home: HomeScreen());
  }
}
