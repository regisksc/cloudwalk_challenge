import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../../weather.dart';

class WeatherConditionsContainer extends StatelessWidget {
  const WeatherConditionsContainer(this.forecast, {super.key});

  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isBigScreen = size.shortestSide > 650;
    if (isBigScreen) return _LargerScreenLayout(forecast);
    return _ShorterScreenLayout(forecast: forecast, width: width).asCard;
  }
}

class _LargerScreenLayout extends StatelessWidget {
  const _LargerScreenLayout(this.forecast);

  final WeatherForecast forecast;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _makeInfoLine(
          context,
          label: 'minimum:',
          value: '${forecast.tempMin.value} °F',
          color: forecast.tempMin.getDangerColor,
        ),
        _makeInfoLine(
          context,
          label: 'maximum:',
          value: '${forecast.tempMax.value} °F',
          color: forecast.tempMin.getDangerColor,
        ),
        _makeInfoLine(
          context,
          icon: FeatherIcons.wind,
          label: 'wind speed:',
          value: '${forecast.windSpeed.value} m/s',
          color: forecast.windSpeed.getDangerColor,
        ),
      ],
    ).asCard;
  }

  Widget _makeInfoLine(
    BuildContext context, {
    IconData? icon,
    required String label,
    required Color color,
    required String value,
  }) {
    final theme = Theme.of(context);
    final longestSide = MediaQuery.of(context).size.longestSide;
    return DefaultTextStyle.merge(
      style: theme.primaryTextTheme.headlineMedium?.copyWith(color: color),
      child: Row(
        children: [
          const Spacer(),
          Icon(icon ?? FeatherIcons.thermometer, color: color, size: longestSide * .03),
          Text(label),
          const Spacer(),
          Text(value),
          const Spacer(),
        ],
      ),
    );
  }
}

class _ShorterScreenLayout extends StatelessWidget {
  const _ShorterScreenLayout({
    required this.forecast,
    required this.width,
  });

  final WeatherForecast forecast;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: [
            Expanded(child: TemperatureIndicator(label: 'min', temperature: forecast.tempMin)),
            Expanded(child: TemperatureIndicator(label: 'max', temperature: forecast.tempMax))
          ].toColumn(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.027),
          child: Row(children: [
            Text(
              forecast.weatherDescription,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            WindSpeedIndicator(speed: forecast.windSpeed),
          ]),
        ),
      ],
    );
  }
}
