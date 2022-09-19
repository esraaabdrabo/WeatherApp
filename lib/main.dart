import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_model_provider.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => WeatherProvider(), child: WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Provider.of<WeatherProvider>(context).weatherData == null
            ? Colors.blue
            : Provider.of<WeatherProvider>(context).weatherData!.getColor(),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
