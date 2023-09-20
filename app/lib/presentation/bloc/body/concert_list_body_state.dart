import 'package:cities/cities.dart';
import 'package:core/core.dart';

abstract class ConcertListBodyState extends Equatable {}

class NextConcerts extends ConcertListBodyState {
  @override
  List<Object?> get props => [];
}

class Loading extends ConcertListBodyState {
  List<Object?> get props => [];
}

class DataFetched extends ConcertListBodyState {
  DataFetched(this.cities);

  final List<Geolocation> cities;
  List<Object?> get props => [cities];
}

class FetchFailed extends ConcertListBodyState {
  FetchFailed({required this.errorMessage});

  final String errorMessage;
  List<Object?> get props => [errorMessage];
}
