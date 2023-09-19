import 'package:cities/cities.dart';
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
    final remotelyGeolocateCity = ErrorHandleDecorator<City, City>(RemotelyGeolocateCity(httpAdapter)) as GeolocateCity;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: ConcertListBodyCubit(remotelyGeolocateCity)),
      ],
      child: page,
    );
  }
}
