import 'package:cities/cities.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

abstract class ConcertListBodyState extends Equatable {
  const ConcertListBodyState({this.cities});

  final List<Geolocation>? cities;
  @override
  List<Object?> get props => [cities];
}

class NextConcerts extends ConcertListBodyState {
  NextConcerts({required List<Geolocation> initialCities}) : super(cities: initialCities) {
    debugPrint('NextConcerts constructor called with cities: $cities');
  }
}

class Loading extends ConcertListBodyState {}

class DataFetched extends ConcertListBodyState {
  DataFetched(List<Geolocation> cities) : super(cities: cities) {
    debugPrint('DataFetched constructor called with cities: $cities');
  }
}

class FetchFailed extends ConcertListBodyState {
  const FetchFailed({required this.errorMessage, this.wasNotFound = false});

  final String errorMessage;
  final bool wasNotFound;

  @override
  List<Object?> get props => [errorMessage];
}
