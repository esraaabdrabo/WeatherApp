import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/provider/weather_model_provider.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search a city')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: ((value) {
              cityName = value;
            }),
            onSubmitted: ((data) async {
              cityName = data;

              WeatherService weatherService = WeatherService();
              WeatherModel? weather =
                  await weatherService.getWeather(cityName: cityName!);
              Provider.of<WeatherProvider>(context, listen: false).weatherData =
                  weather;
              Provider.of<WeatherProvider>(context, listen: false).cityName =
                  cityName;

              Navigator.pop(context);
            }),
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () async {
                      WeatherService weatherService = WeatherService();
                      WeatherModel? weather =
                          await weatherService.getWeather(cityName: cityName!);
                      Provider.of<WeatherProvider>(context, listen: false)
                          .weatherData = weather;
                      Provider.of<WeatherProvider>(context, listen: false)
                          .cityName = cityName;

                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.search)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                hintText: 'Search a city',
                label: const Text('Search'),
                border: const OutlineInputBorder(borderSide: BorderSide(width: 1))),
          ),
        ),
      ),
    );
  }
}
