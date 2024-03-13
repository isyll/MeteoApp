import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meteo_app/widgets/weather_today.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Application Météo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'Roboto'),
        home: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [WeatherToday(), const Center(child: Text('adinedein'))],
        ));
  }
}
