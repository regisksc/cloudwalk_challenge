import 'package:cities/cities.dart';
import 'package:core/core.dart';
import '../../presentation.dart';

class ConcertListBodyCubit extends Cubit<ConcertListBodyState> {
  ConcertListBodyCubit(Usecase<List<Geolocation>, GeolocationInput> geolocateCity)
      : _geolocateCity = geolocateCity,
        super(NextConcerts(initialCities: initialCities));

  final Usecase<List<Geolocation>, GeolocationInput> _geolocateCity;

  static List<Geolocation> initialCities = <String>[
    'Silverstone, UK',
    'São Paulo, Brazil',
    'Melbourne, Australia',
    'Monte Carlo, Monaco',
  ]
      .map(
        (cityName) => Geolocation(
          name: cityName.split(', ').first,
          country: cityName.split(', ').last,
          modifiedWhen: DateTime.now().toUtc(),
        ),
      )
      .toList();

  Future geolocalizeStartingList() async {
    if (initialCities.first.lat != null) {
      emit(NextConcerts(initialCities: initialCities));
      return;
    }
    try {
      final futures = Future.wait(
          initialCities.map((e) => _geolocateCity(GeolocationInput(cityName: e.name.split(', ').first))).toList());
      final geolocations = await futures;
      final geolocatedCities = geolocations
          .map((e) => e.firstOrNull ?? Geolocation(name: '', modifiedWhen: DateTime.now().toUtc()))
          .toList();
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

  Future geolocateACity(String cityName) async {
    emit(Loading());
    try {
      final geolocatedCities = await _geolocateCity(GeolocationInput(cityName: cityName));
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
