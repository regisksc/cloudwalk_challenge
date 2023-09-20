import 'dart:async';

import 'package:cities/cities.dart';
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
  final _textController = TextEditingController();
  Timer? _debounce;

  late final ConcertListBodyCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<ConcertListBodyCubit>();
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
      () => context.read<ConcertListBodyCubit>().geolocateCity(
            GeolocationInput(cityName: value.isNotEmpty ? value : ''),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_appBarIsSearching
            ? const Text('Next concerts')
            : TextField(
                controller: _textController,
                decoration: const InputDecoration(hintText: 'Get weather for a city', border: InputBorder.none),
                onChanged: (value) => _onTextChanged(value),
              ),
        actions: [
          Icon(hasConnection ? FeatherIcons.wifi : FeatherIcons.wifi),
          IconButton(
            icon: _appBarIsSearching ? const Icon(FeatherIcons.x) : const Icon(FeatherIcons.search),
            onPressed: () => setState(() => _appBarIsSearching = !_appBarIsSearching),
          ),
        ],
      ),
      body: const BodyList(),
    );
  }
}
