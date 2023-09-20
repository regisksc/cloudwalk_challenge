import 'package:cities/cities.dart';
import 'package:core/core.dart';
import '../../presentation.dart';

class ConcertListBodyCubit extends Cubit<ConcertListBodyState> {
  ConcertListBodyCubit(this.geolocateCity) : super(NextConcerts());

  final Usecase<List<Geolocation>, GeolocationInput> geolocateCity;

  Future geolocateACity(String cityName) async {
    emit(Loading());
    try {
      final geolocatedCities = await geolocateCity(GeolocationInput(cityName: cityName));
      emit(DataFetched(geolocatedCities));
    } catch (e) {
      final message = e is ServerFailure
          ? 'Our services are unstable, please try again in a few minutes'
          : 'An error occured, please contact Admin';
      emit(FetchFailed(errorMessage: message));
    }
  }
}
