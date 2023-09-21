import 'package:flutter/material.dart';

extension DoubleExtensions on num {
  double asScreenHeightPercentage(BuildContext context) => MediaQuery.of(context).size.height * this / 100;
  double asScreenWidthPercentage(BuildContext context) => MediaQuery.of(context).size.width * this / 100;
  double scalingIcon(BuildContext context) => MediaQuery.of(context).size.aspectRatio * this;
}
