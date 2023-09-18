import 'package:flutter/material.dart';

import 'presentation.dart';

class ConcertListPage extends StatefulWidget {
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
  State<ConcertListPage> createState() => _ConcertListPageState();
}

class _ConcertListPageState extends State<ConcertListPage> {
  bool get hasConnection => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    context.read<ConcertListBodyCubit>().close();
  }

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
        restorationId: ConcertListPage.routeName,
        itemCount: widget.locations.length,
        itemBuilder: (BuildContext context, int index) {
          final location = widget.locations[index].split(',').first;

          return ListTile(
            title: Text(location),
            leading: const CircleAvatar(child: Icon(FeatherIcons.mapPin)),
            onTap: () {
              // Navigator.restorablePushNamed(
              //   context,
              //   ConcertDetailsView.routeName,
              // );
            },
          );
        },
      ),
    );
  }
}
