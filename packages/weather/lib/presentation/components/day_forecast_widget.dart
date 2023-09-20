import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../weather.dart';

class DayForecastWidget extends StatelessWidget {
  const DayForecastWidget(this.forecast, {super.key});

  final WeatherForecast forecast;

  Container _wrapWithGreyPill(
    BuildContext context, {
    required double width,
    required Widget child,
  }) {
    return Container(
      height: 80,
      width: width,
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.grey.shade700, borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeSplit = forecast.time.formatted.split('-');
    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _wrapWithGreyPill(
              context,
              width: 120,
              child: Text(
                '${timeSplit[0]}\n${timeSplit[1]}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(color: Colors.white70),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _wrapWithGreyPill(
                  context,
                  width: 220,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Expanded(child: TemperatureContainer(label: 'min', temperature: forecast.tempMin)),
                                Expanded(child: TemperatureContainer(label: 'max', temperature: forecast.tempMax))
                              ],
                            ),
                            const SizedBox(width: 10),
                            _WindSpeedIndicator(speed: forecast.windSpeed),
                          ],
                        ),
                      ),
                      Text(
                        forecast.weatherDescription,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
          '${speed.value.toString()} m/s',
          style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(color: speed.getDangerColor),
        ),
        const SizedBox(),
      ],
    );
  }
}

class TemperatureContainer extends StatelessWidget {
  const TemperatureContainer({super.key, required this.label, required this.temperature});

  final Temperature temperature;
  final String label;

  TextSpan _text(BuildContext context,
      {required String text, required Color color, double? size, List<TextSpan>? children}) {
    return TextSpan(
      text: text,
      style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(color: color, fontSize: size),
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(FeatherIcons.thermometer, color: temperature.getDangerColor, size: 16),
        RichText(
          text: _text(
            context,
            text: ' $label: ',
            color: Colors.white60,
            children: [
              _text(context, text: temperature.value.toString(), color: temperature.getDangerColor, size: 16),
              _text(context, text: ' °F', color: temperature.getDangerColor, size: 12),
            ],
          ),
        ),
      ],
    );
  }
}
