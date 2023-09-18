import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ConcertListPage extends StatelessWidget {
  const ConcertListPage({
    super.key,
    this.locations = const <String>[
      'Silverstone, UK',
      'São Paulo, Brazil',
      'Melbourne, Australia',
      'Monte Carlo, Monaco',
    ],
  });

  final List<String> locations;

  static const String routeName = '/concerts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next concerts'),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            icon: const Icon(FeatherIcons.wifi),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(FeatherIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: routeName,
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          final location = locations[index].split(',').first;

          return ListTile(
              title: Text(location),
              leading: const CircleAvatar(child: Icon(FeatherIcons.mapPin)),
              onTap: () {
                // Navigator.restorablePushNamed(
                //   context,
                //   ConcertDetailsView.routeName,
                // );
              });
        },
      ),
    );
  }
}
