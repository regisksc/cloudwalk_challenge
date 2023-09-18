import 'package:bloc_test/bloc_test.dart';
import 'package:cities/cities.dart';
import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:core/core.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocateCity extends Mock implements GeolocateCity {}

void main() {
  late City mockCity;

  setUpAll(() {
    mockCity = City(
      name: faker.address.city(),
      geolocation: Geolocation(
        latitude: faker.geo.latitude(),
        longitude: faker.geo.longitude(),
      ),
    );
    registerFallbackValue(mockCity);
  });

  final mockGeolocateCity = MockGeolocateCity();

  blocTest<ConcertListBodyCubit, ConcertListBodyState>(
    'emits Loading and DataFetched states when geolocation is successful',
    build: () {
      when(() => mockGeolocateCity(any())).thenAnswer((_) async => mockCity);
      return ConcertListBodyCubit(mockGeolocateCity);
    },
    act: (cubit) => cubit.geolocateACity('CityName'),
    expect: () => [Loading(), DataFetched(mockCity)],
  );

  blocTest<ConcertListBodyCubit, ConcertListBodyState>(
    'emits Loading and FetchFailed states when geolocation fails from Server',
    build: () {
      when(() => mockGeolocateCity(any())).thenThrow(ServerFailure());
      return ConcertListBodyCubit(mockGeolocateCity);
    },
    act: (cubit) => cubit.geolocateACity('CityName'),
    expect: () => [
      Loading(),
      FetchFailed(errorMessage: 'Our services are unstable, please try again in a few minutes'),
    ],
  );

  blocTest<ConcertListBodyCubit, ConcertListBodyState>(
    'emits Loading and FetchFailed states when geolocation fails from Client',
    build: () {
      when(() => mockGeolocateCity(any())).thenThrow(ClientFailure());
      return ConcertListBodyCubit(mockGeolocateCity);
    },
    act: (cubit) => cubit.geolocateACity('CityName'),
    expect: () => [
      Loading(),
      FetchFailed(errorMessage: 'An error occured, please contact Admin'),
    ],
  );
}
