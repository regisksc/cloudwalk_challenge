import 'package:flutter/material.dart';

import '../../weather.dart';

extension TemperatureExtensions on Temperature {
  ColorSwatch<int> get getDangerColor {
    return switch (danger) {
      TemperatureDanger.cold => Colors.lightBlueAccent,
      TemperatureDanger.warm => Colors.blueAccent,
      TemperatureDanger.hot => Colors.amber,
      _ => Colors.red,
    };
  }
}

extension WindSpeedExtensions on WindSpeed {
  ColorSwatch<int> get getDangerColor {
    return switch (danger) {
      WindSpeedDanger.low => Colors.green,
      WindSpeedDanger.moderate => Colors.orange,
      WindSpeedDanger.high => Colors.red,
    };
  }
}
