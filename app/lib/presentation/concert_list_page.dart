import 'dart:async';

import 'package:flutter/material.dart';

import 'presentation.dart';

class ConcertListPage extends StatefulWidget {
  const ConcertListPage({
    super.key,
  });

  static const String routeName = '/concerts';

  @override
  State<ConcertListPage> createState() => _ConcertListPageState();
}

class _ConcertListPageState extends State<ConcertListPage> {
  bool get hasConnection => true;

  bool _appBarIsSearching = false;
  late TextEditingController _textController;
  Timer? _debounce;

  late final ConcertListBodyCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<ConcertListBodyCubit>();
    _cubit.geolocalizeStartingList();
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    _debounce?.cancel();
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(seconds: 2),
      () => _cubit.geolocateACity(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _makeAppBar(context),
      body: const BodyList(),
      floatingActionButton: const ShowInitialListFab(),
    );
  }

  AppBar _makeAppBar(BuildContext context) {
    return AppBar(
      title: !_appBarIsSearching
          ? BlocBuilder<ConcertListBodyCubit, ConcertListBodyState>(
              builder: (context, state) {
                final titleText = state is! NextConcerts ? 'Result' : 'Next concerts';

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final fontSize = constraints.maxWidth * 0.05;
                    return Text(titleText, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold));
                  },
                );
              },
            )
          : TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: 'Get weather for a city', border: InputBorder.none),
              onChanged: (value) => _onTextChanged(value),
            ),
      actions: [
        const SizedBox(),
        SizedBox(
          height: MediaQuery.of(context).size.longestSide * .06,
          width: MediaQuery.of(context).size.longestSide * .06,
          child: FittedBox(
            child: IconButton(
              icon: _appBarIsSearching ? const Icon(FeatherIcons.x) : const Icon(FeatherIcons.search),
              onPressed: () => setState(() {
                if (_appBarIsSearching) _textController.clear();
                _appBarIsSearching = !_appBarIsSearching;
              }),
            ),
          ),
        ),
      ],
    );
  }
}
