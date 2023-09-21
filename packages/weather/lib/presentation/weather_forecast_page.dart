import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../weather.dart';

class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({
    super.key,
    required this.input,
  });

  final WeatherFetchingInput input;

  static const String routeName = '/weather';

  @override
  State<WeatherForecastPage> createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  late CurrentWeatherCubit _currentWeatherCubit;
  late WeatherForecastCubit _weatherForecastCubit;
  @override
  void initState() {
    super.initState();
    _currentWeatherCubit = context.read<CurrentWeatherCubit>();
    _weatherForecastCubit = context.read<WeatherForecastCubit>();
    _currentWeatherCubit.getCurrentWeather(widget.input);
    _weatherForecastCubit.getWeatherForecast(widget.input);
  }

  @override
  void dispose() {
    _currentWeatherCubit.close();
    _weatherForecastCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(flex: 8, child: PageHeaderWidget(title: widget.input.cityName)),
              Expanded(
                flex: 20,
                child: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
                  builder: (context, state) => WeatherForecastList(state: state, title: 'current condition'),
                ),
              ),
              Expanded(
                flex: 72,
                child: BlocBuilder<WeatherForecastCubit, WeatherForecastState>(
                  builder: (context, state) => WeatherForecastList(state: state, title: 'next five days'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherForecastList extends StatelessWidget {
  const WeatherForecastList({required this.title, required this.state});

  final String title;
  final WeatherState state;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final maxMarginWidth = width * 0.08;
    final marginPercentage = maxMarginWidth < width * 0.02 ? maxMarginWidth / width : 0.02;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * marginPercentage),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              title,
              style: Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(color: Colors.black87),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final height = MediaQuery.of(context).size.height;
                if (state is LoadingState) {
                  return const Loader();
                } else if (state is WeatherError)
                  return const AlertIcon();
                else if (state is CurrentWeatherLoaded) {
                  return DayForecastWidget((state as CurrentWeatherLoaded).weather);
                }
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(height: (state as WeatherForecastLoaded).forecasts.length > 1 ? height * .0156 : 0),
                  itemCount: (state as WeatherForecastLoaded).forecasts.length,
                  itemBuilder: (context, index) => DayForecastWidget((state as WeatherForecastLoaded).forecasts[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class AlertIcon extends StatelessWidget {
  const AlertIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: Icon(FeatherIcons.alertOctagon, color: Colors.red, size: 32),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator.adaptive(backgroundColor: Colors.deepOrangeAccent),
    );
  }
}
