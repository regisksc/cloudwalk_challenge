import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../weather.dart';
import '../presentation.dart';

class DayForecastWidget extends StatelessWidget {
  const DayForecastWidget(this.forecast, {super.key});

  final WeatherForecast forecast;

  Container _wrapWithGreyPill(BuildContext context, Widget child) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.grey.shade700, borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeSplit = forecast.time.formatted.split(',');
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _wrapWithGreyPill(
            context,
            Text(
              '${timeSplit[0]}${timeSplit[1]}',
              style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(color: Colors.white70),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _wrapWithGreyPill(
              context,
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TemperatureIndicator(minimum: forecast.tempMin, maximum: forecast.tempMax),
                  _WindSpeedIndicator(speed: forecast.windSpeed),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text(
              forecast.weatherDescription,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _WindSpeedIndicator extends StatelessWidget {
  const _WindSpeedIndicator({required this.speed});

  final WindSpeed speed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(FeatherIcons.wind, color: speed.getDangerColor, size: 16),
        Text(
          speed.value.toString(),
          style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(color: speed.getDangerColor),
        ),
        const SizedBox(),
      ],
    );
  }
}

class _TemperatureIndicator extends StatelessWidget {
  const _TemperatureIndicator({
    required this.minimum,
    required this.maximum,
  });

  final Temperature minimum;
  final Temperature maximum;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(FeatherIcons.thermometer, color: maximum.getDangerColor, size: 16),
        RichText(
          text: _text(context, text: ' min: ', color: Colors.white60, children: [
            _text(context, text: minimum.value.toString(), color: minimum.getDangerColor, size: 16),
            _text(context, text: ' °F', color: minimum.getDangerColor, size: 12),
            _text(context, text: ' / max: ', color: Colors.white60),
            _text(context, text: maximum.value.toString(), color: minimum.getDangerColor, size: 16),
            _text(context, text: ' °F', color: minimum.getDangerColor, size: 12),
          ]),
        ),
      ],
    );
  }

  TextSpan _text(
    BuildContext context, {
    required String text,
    required Color color,
    double? size,
    List<TextSpan>? children,
  }) {
    return TextSpan(
      text: text,
      style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(color: color, fontSize: size),
      children: children,
    );
  }
}
