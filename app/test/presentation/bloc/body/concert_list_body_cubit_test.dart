import 'package:bloc_test/bloc_test.dart';
import 'package:cities/cities.dart';
import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:core/core.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocateCity extends Mock implements Usecase<List<Geolocation>, GeolocationInput> {}

class MockGeolocation extends Mock implements Geolocation {}

void main() {
  late MockGeolocateCity mockGeolocateCity;
  late List<Geolocation> mockGeolocations;

  setUp(() {
    mockGeolocateCity = MockGeolocateCity();
    mockGeolocations = List.generate(5, (i) => MockGeolocation());
  });

  setUpAll(() {
    registerFallbackValue(GeolocationInput(cityName: faker.address.city()));
  });

  blocTest<ConcertListBodyCubit, ConcertListBodyState>(
    'emits Loading and DataFetched states when geolocateACity is successful',
    build: () {
      when(() => mockGeolocateCity(any())).thenAnswer((_) async => mockGeolocations);
      return ConcertListBodyCubit(mockGeolocateCity);
    },
    act: (sut) => sut.geolocateACity('CityName'),
    expect: () => [Loading(), DataFetched(mockGeolocations)],
  );

  blocTest<ConcertListBodyCubit, ConcertListBodyState>(
    'emits Loading and FetchFailed states when geolocateACity throws a Failure',
    build: () {
      when(() => mockGeolocateCity(any())).thenThrow(ServerFailure());
      return ConcertListBodyCubit(mockGeolocateCity);
    },
    act: (sut) => sut.geolocateACity('CityName'),
    expect: () => [
      Loading(),
      FetchFailed(errorMessage: 'Our services are unstable, please try again in a few minutes'),
    ],
  );

  blocTest<ConcertListBodyCubit, ConcertListBodyState>(
    'emits Loading and FetchFailed states when geolocateACity throws an Error',
    build: () {
      when(() => mockGeolocateCity(any())).thenThrow(Exception());
      return ConcertListBodyCubit(mockGeolocateCity);
    },
    act: (sut) => sut.geolocateACity('CityName'),
    expect: () => [
      Loading(),
      FetchFailed(errorMessage: 'An error occured, please contact Admin'),
    ],
  );
}
