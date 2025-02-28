import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/model/weather_state.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_model_provider.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => WeatherProvider(), child: const WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Provider.of<WeatherProvider>(context).weatherData == null
            //Todo using hard coded color is not a good practice, we need to use the color from a class after encapsulating the colors into one.
            ? Colors.blue
            : Provider.of<WeatherProvider>(context).weatherData!.state.color,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
