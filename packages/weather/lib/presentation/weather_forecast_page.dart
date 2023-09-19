import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../weather.dart';
import 'presentation.dart';

class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({
    super.key,
    required this.input,
    required this.title,
  });

  final WeatherFetchingInput input;
  final String title;

  static String get routeName => '/weather';

  @override
  State<WeatherForecastPage> createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  @override
  void initState() {
    super.initState();

    context.read<WeatherCubit>().getCurrentWeather(widget.input);
    context.read<WeatherCubit>().getWeatherForecast(widget.input);
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
                flex: 15,
                child: BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    if (state is CurrentWeatherLoading) return const CircularProgressIndicator.adaptive();
                    if (state is CurrentWeatherError) return WeatherForecastList.error();
                    if (state is CurrentWeatherLoaded) {
                      return WeatherForecastList(title: 'current condition', forecasts: [state.weather]);
                    } else {
                      return const Offstage();
                    }
                  },
                ),
              ),
              Expanded(
                flex: 52,
                child: BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherForecastLoading) return const CircularProgressIndicator.adaptive();
                    if (state is WeatherForecastError) return WeatherForecastList.error();
                    if (state is WeatherForecastLoaded) {
                      return WeatherForecastList(title: 'next 5 days', forecasts: state.forecasts.sublist(0, 5));
                    } else {
                      return const Offstage();
                    }
                  },
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
  const WeatherForecastList({
    super.key,
    this.title,
    this.forecasts,
    this.errorWidget,
  });

  factory WeatherForecastList.error() {
    _hasError = true;
    return const WeatherForecastList();
  }

  static bool _hasError = false;

  final String? title;
  final List<WeatherForecast>? forecasts;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    if (_hasError) return const Center(child: Icon(FeatherIcons.alertOctagon, color: Colors.red, size: 32));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .02),
      child: Column(
        children: [
          Text(title!, style: Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(color: Colors.black87)),
          Expanded(
            child: ListView.builder(
              itemCount: forecasts!.length,
              physics: forecasts!.length <= 5 ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
              itemBuilder: (context, index) => DayForecastWidget(forecasts![index]),
            ),
          ),
        ],
      ),
    );
  }
}
