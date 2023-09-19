import 'package:cities/cities.dart';
import 'package:flutter/material.dart';

import '../weather.dart';
import 'presentation.dart';

class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({super.key});

  @override
  State<WeatherForecastPage> createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  City get city => City(name: 'Liverpool');
  WeatherForecast get weatherForecast => WeatherForecast(
        weatherDescription: 'Um friozinho, mas da',
        time: ForecastTime(unixTimestamp: 1631875200, locale: 'pt'),
        tempMin: Temperature(value: 14),
        tempMax: Temperature(value: 22),
        windSpeed: WindSpeed(value: 14.2),
      );
  List<WeatherForecast> get forecasts => List.generate(5, (index) => weatherForecast);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 8, child: PageHeaderWidget(title: city.name)),
              Expanded(flex: 15, child: WeatherForecastList(title: 'current condition', forecasts: [weatherForecast])),
              Expanded(flex: 52, child: WeatherForecastList(title: 'next 5 days', forecasts: forecasts.sublist(0, 5))),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherForecastList extends StatelessWidget {
  const WeatherForecastList({
    super.key,
    required this.title,
    required this.forecasts,
  });

  final String title;
  final List<WeatherForecast> forecasts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .02),
      child: Column(
        children: [
          Text(title, style: Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(color: Colors.black87)),
          Expanded(
            child: ListView.builder(
              itemCount: forecasts.length,
              physics: forecasts.length <= 5 ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
              itemBuilder: (context, index) => DayForecastWidget(forecasts[index]),
            ),
          ),
        ],
      ),
    );
  }
}
