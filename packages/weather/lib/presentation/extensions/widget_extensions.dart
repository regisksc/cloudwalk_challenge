import 'package:flutter/material.dart';

extension CardExtension on Widget {
  Widget get asCard {
    return Card(
      elevation: 40,
      child: Container(
        padding: const EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.grey.shade700, borderRadius: BorderRadius.circular(8)),
        child: this,
      ),
    );
  }
}

extension WidgetArrayExtension on List<Widget> {
  Column toColumn() => Column(children: this);
  Row toRow({MainAxisAlignment? mainAxisAlignment}) => Row(children: this);
}
