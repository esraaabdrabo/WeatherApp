import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/model/weather_state.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;

  String? errorMessage;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    //Todo  no need for updating the whole widget when the weather data is updated, we need to update only the weather data and its related widgets.
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          actions: [
            IconButton(
              onPressed: () async {
                // decoupling between navigation logic and UI, the UI should not be care about the navigation way(Dependency Inversion Principle).
                final String? searchTerm = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const SearchPage()),
                  ),
                );
                if (searchTerm?.isEmpty ?? false) {
                  if (context.mounted) {
                    Provider.of<WeatherProvider>(context)
                        .getWeather(name: searchTerm!);
                  }
                }
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Consumer(
          builder: (context, ref, child) {
            weatherData = Provider.of<WeatherProvider>(context).weatherData;
            errorMessage = Provider.of<WeatherProvider>(context).errorMessage;
            isLoading = Provider.of<WeatherProvider>(context).isLoading;

            return isLoading
                ? const _LoadingView()
                : errorMessage != null
                    ? _ErrorView(errorMessage: errorMessage!)
                    : weatherData != null
                        ? Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Provider.of<WeatherProvider>(context)
                                      .weatherData!
                                      .state
                                      .color[500]!,
                                  Provider.of<WeatherProvider>(context)
                                      .weatherData!
                                      .state
                                      .color[300]!,
                                  Provider.of<WeatherProvider>(context)
                                      .weatherData!
                                      .state
                                      .color[100]!,
                                ])),
                            child: Column(
                              children: [
                                const Spacer(
                                  flex: 3,
                                ),
                                Text(
                                  Provider.of<WeatherProvider>(context)
                                      .cityName!,
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'update at ${weatherData!.date.hour.toString()}: ${weatherData!.date.minute.toString()}',
                                  style: const TextStyle(fontSize: 22),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.network(
                                      'https:${weatherData!.icon.toString()}',
                                    ),
                                    Text(
                                      '${weatherData!.temp.toInt()}',
                                      style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
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
                                  weatherData!.state.displayName,
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(
                                  flex: 5,
                                )
                              ],
                            ),
                          )
                        : const _NoDataView();
          },
        ));
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _NoDataView extends StatelessWidget {
  const _NoDataView();

  @override
  Widget build(BuildContext context) {
    return const Center(
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
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "$errorMessage 😔",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    ));
  }
}
