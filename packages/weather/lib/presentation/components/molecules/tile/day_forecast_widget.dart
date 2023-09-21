import 'package:flutter/material.dart';

import '../../../../weather.dart';

class DayForecastWidget extends StatelessWidget {
  const DayForecastWidget(this.forecast, {super.key});

  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .125,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(flex: 38, child: DateContainer(forecast)),
          const Spacer(),
          Expanded(flex: 61, child: WeatherConditionsContainer(forecast)),
        ],
      ),
    );
  }
}
