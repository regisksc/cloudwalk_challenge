import 'package:flutter/material.dart';

import '../../../../../weather.dart';

class DateContainer extends StatelessWidget {
  const DateContainer(this.forecast, {super.key});
  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isBigScreen = size.shortestSide > 650;
    final timeSplit = forecast.time.formatted.split('-');
    final width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              '${timeSplit[0]}\n${timeSplit[1]}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .primaryTextTheme
                  .labelMedium
                  ?.copyWith(color: Colors.white70, fontSize: width * (isBigScreen ? .04 : .045)),
            ),
          ),
          Text(
            'updated: ${forecast.timeSinceLastModified()}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .primaryTextTheme
                .labelMedium
                ?.copyWith(color: Colors.white70, fontSize: width * .03 * (2 / 3)),
          ),
        ],
      ).asCard,
    );
  }
}
