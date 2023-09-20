import 'package:cities/cities.dart';
import 'package:core/core.dart';
import '../../presentation.dart';

class ConcertListBodyCubit extends Cubit<ConcertListBodyState> {
  ConcertListBodyCubit(this._geolocateCityRemotely, this._geolocateCityLocally)
      : super(NextConcerts(initialCities: initialCities));

  final Usecase<List<Geolocation>, GeolocationInput> _geolocateCityRemotely;
  final Usecase<List<Geolocation>, GeolocationInput> _geolocateCityLocally;

  static List<Geolocation> initialCities = <String>[
    'Silverstone, UK',
    'São Paulo, Brazil',
    'Melbourne, Australia',
    'Monte Carlo, Monaco',
  ].map((cityName) => Geolocation(name: cityName, country: cityName.split(', ').last)).toList();

  Future geolocalizeStartingList({bool local = false}) async {
    try {
      final futures = Future.wait(initialCities.map((e) {
        final usecase = local ? _geolocateCityLocally : _geolocateCityRemotely;
        return usecase(GeolocationInput(cityName: e.name.split(', ').first));
      }).toList());
      final geolocations = await futures;
      final geolocatedCities = geolocations.map((e) => e.firstOrNull ?? Geolocation(name: '')).toList();
      initialCities = geolocatedCities;
      emit(NextConcerts(initialCities: geolocatedCities));
    } catch (e) {
      final message = e is ServerFailure
          ? 'Our services are unstable, please try again in a few minutes'
          : 'An error occured, please contact Admin';
      emit(FetchFailed(
        errorMessage: message,
        wasNotFound: e is NotFoundFailure || e is ReadingFailure,
      ));
    }
  }

  Future geolocateACity(String cityName, {bool local = false}) async {
    emit(Loading());
    try {
      final usecase = local ? _geolocateCityLocally : _geolocateCityRemotely;
      final geolocatedCities = await usecase(GeolocationInput(cityName: cityName));
      emit(DataFetched(geolocatedCities));
    } catch (e) {
      final message = e is ServerFailure
          ? 'Our services are unstable, please try again in a few minutes'
          : 'An error occured, please contact Admin';
      emit(FetchFailed(
        errorMessage: message,
        wasNotFound: e is NotFoundFailure || e is ReadingFailure,
      ));
    }
  }
}
