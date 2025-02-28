import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/provider/weather_model_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    //Todo  no need for updating the whole widget when the weather data is updated, we need to update only the weather data and its related widgets.
    weatherData = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
              onPressed: () {
                // decoupling between navigation logic and UI, the UI should not be care about the navigation way(Dependency Inversion Principle).

                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => SearchPage())));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: weatherData != null
          ? Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Provider.of<WeatherProvider>(context)
                        .weatherData!
                        .getColor()[500]!,
                    Provider.of<WeatherProvider>(context)
                        .weatherData!
                        .getColor()[300]!,
                    Provider.of<WeatherProvider>(context)
                        .weatherData!
                        .getColor()[100]!,
                  ])),
              child: Column(
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    Provider.of<WeatherProvider>(context).cityName!,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'update at ${weatherData!.date.hour.toString()}: ${weatherData!.date.minute.toString()}',
                    style: const TextStyle(fontSize: 22),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        'https:${weatherData!.icon.toString()}',
                      ),
                      Text(
                        '${weatherData!.temp.toInt()}',
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Text(
                            'maxTemp : ${weatherData!.maxTemp.toInt()}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'minTemp : ${weatherData!.minTemp.toInt()}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    weatherData!.weatherStateName,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(
                    flex: 5,
                  )
                ],
              ),
            )
          : const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'there is no weather 😔 start',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'searching now 🔍',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
