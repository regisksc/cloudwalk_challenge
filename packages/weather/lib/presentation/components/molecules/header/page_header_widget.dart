import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class PageHeaderWidget extends StatelessWidget {
  const PageHeaderWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 15,
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: Visibility(
                visible: Navigator.of(context).canPop(),
                child: IconButton(
                  icon: Icon(Platform.isIOS ? FeatherIcons.chevronLeft : FeatherIcons.arrowLeft),
                  splashColor: Colors.transparent,
                  onPressed: Navigator.of(context).canPop() ? () => Navigator.of(context).pop() : null,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 70,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
          ),
          const Expanded(flex: 15, child: SizedBox()),
        ],
      ),
    );
  }
}
