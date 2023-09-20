import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../weather.dart';

class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({
    super.key,
    required this.input,
    required this.title,
  });

  final WeatherFetchingInput input;
  final String title;

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 8, child: PageHeaderWidget(title: widget.title)),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .02),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(color: Colors.black87),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (state is LoadingState) {
                  return Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    child: const CircularProgressIndicator.adaptive(),
                  );
                } else if (state is WeatherError)
                  return const Icon(FeatherIcons.alertOctagon, color: Colors.red, size: 32);
                else if (state is CurrentWeatherLoaded) {
                  return DayForecastWidget((state as CurrentWeatherLoaded).weather);
                }
                return ListView.builder(
                  itemCount: (state as WeatherForecastLoaded).forecasts.length,
                  itemBuilder: (context, index) {
                    return DayForecastWidget((state as WeatherForecastLoaded).forecasts[index]);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
