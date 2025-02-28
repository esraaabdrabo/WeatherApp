import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/provider/weather_model_provider.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search a city')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          //Todo it's preferred to extract the TextField to a separate widget to make the code more readable, maintainable, and to be reused whenever it's needed.
          child: TextField(
            onChanged: ((value) {
              cityName = value;
            }),
            onSubmitted: ((data) async {
              cityName = data;
              //Todo using WeatherService here will make the SearchPage class depend on the WeatherService class,
              // which is not a good practice. We need to use the WeatherProvider class to get the weather data (Dependency inversion=> tightly coupled).
              // also violates single responsibility principle, the class should have only one reason to change
              // so if the WeatherService requires param to be sent this will make change in searchPage just to modify WeatherService object.
              // or event if the flow of getting the weather data changed like support caching to DB, this will make change in SearchPage class.
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
                      //Todo need to use singleton pattern here instead of creating an instance every time we need to get the weather data.
                      // also, we need to use the WeatherProvider class to get the weather data (Dependency inversion=> tightly coupled).
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
                border:
                    const OutlineInputBorder(borderSide: BorderSide(width: 1))),
          ),
        ),
      ),
    );
  }
}
