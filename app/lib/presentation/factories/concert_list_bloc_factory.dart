import 'package:cities/cities.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../presentation.dart';

class ConcertListBlocFactory {
  // coverage:ignore-line
  ConcertListBlocFactory._();

  static MultiBlocProvider instance({
    required HttpClient httpAdapter,
    required Storage storage,
    required Widget page,
  }) {
    final decoratedGeolocateCityUsecase = ConnectionHandleDecorator(
      cacheDecoratee: LocallyGeolocateCity(storage: storage),
      remoteDecoratee: ErrorHandleDecorator<List<Geolocation>, GeolocationInput>(
        RemotelyGeolocateCity(client: httpAdapter, storage: storage),
      ),
      connectivity: Connectivity(),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConcertListBodyCubit(decoratedGeolocateCityUsecase)),
      ],
      child: page,
    );
  }
}
