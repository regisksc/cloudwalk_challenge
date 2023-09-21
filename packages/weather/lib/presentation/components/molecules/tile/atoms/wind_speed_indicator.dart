import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../../../weather.dart';

class WindSpeedIndicator extends StatelessWidget {
  const WindSpeedIndicator({required this.speed});

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
