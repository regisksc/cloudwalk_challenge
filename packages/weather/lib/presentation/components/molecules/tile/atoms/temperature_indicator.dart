import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../../weather.dart';

class TemperatureIndicator extends StatelessWidget {
  const TemperatureIndicator({super.key, required this.label, required this.temperature});

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
    const iconSizeFactor = 1.0;
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 30,
          child: FittedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.aspectRatio * size.longestSide * 0.044),
              child: Icon(FeatherIcons.thermometer, color: temperature.getDangerColor, size: 16 * iconSizeFactor),
            ),
          ),
        ),
        Expanded(
          flex: 60,
          child: RichText(
            text: _text(
              context,
              text: ' $label: ',
              color: Colors.white60,
              children: [
                _text(context, text: temperature.value.toString(), color: temperature.getDangerColor, size: 16),
                _text(context, text: ' °F', color: temperature.getDangerColor, size: 16 * iconSizeFactor * .75),
              ],
            ),
          ),
        ),
        const Spacer(flex: 10),
      ],
    );
  }
}
