import 'package:cities/cities.dart';
import 'package:cities/data/usecases/locally_geolocate_city.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../presentation.dart';

class ConcertListBlocFactory {
  ConcertListBlocFactory._();

  static MultiBlocProvider instance({
    required HttpClient httpAdapter,
    required Storage storage,
    required Widget page,
  }) {
    final remotelyGeolocateCity = ErrorHandleDecorator<List<Geolocation>, GeolocationInput>(
      RemotelyGeolocateCity(client: httpAdapter, storage: storage),
    );
    final locallyGeolocateCity = LocallyGeolocateCity(storage: storage);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConcertListBodyCubit(remotelyGeolocateCity, locallyGeolocateCity)),
      ],
      child: page,
    );
  }
}
