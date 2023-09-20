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
  late MockGeolocateCity mockGeolocateCityRemotely;
  late MockGeolocateCity mockGeolocateCityLocally;
  late List<Geolocation> mockGeolocations;

  setUp(() {
    mockGeolocateCityRemotely = MockGeolocateCity();
    mockGeolocateCityLocally = MockGeolocateCity();
    mockGeolocations = List.generate(5, (i) => MockGeolocation());
  });

  setUpAll(() {
    registerFallbackValue(GeolocationInput(cityName: faker.address.city()));
  });

  group('remote tests - ', () {
    blocTest<ConcertListBodyCubit, ConcertListBodyState>(
      'emits Loading and DataFetched states when geolocateACity is successful',
      build: () {
        when(() => mockGeolocateCityRemotely(any())).thenAnswer((_) async => mockGeolocations);
        return ConcertListBodyCubit(mockGeolocateCityRemotely, mockGeolocateCityLocally);
      },
      act: (sut) => sut.geolocateACity('CityName'),
      expect: () => [Loading(), DataFetched(mockGeolocations)],
    );

    blocTest<ConcertListBodyCubit, ConcertListBodyState>(
      'emits Loading and FetchFailed states when geolocateACity throws a Failure',
      build: () {
        when(() => mockGeolocateCityRemotely(any())).thenThrow(ServerFailure());
        return ConcertListBodyCubit(mockGeolocateCityRemotely, mockGeolocateCityLocally);
      },
      act: (sut) => sut.geolocateACity('CityName'),
      expect: () => [
        Loading(),
        const FetchFailed(errorMessage: 'Our services are unstable, please try again in a few minutes'),
      ],
    );

    blocTest<ConcertListBodyCubit, ConcertListBodyState>(
      'emits Loading and FetchFailed states when geolocateACity throws an Error',
      build: () {
        when(() => mockGeolocateCityRemotely(any())).thenThrow(Exception());
        return ConcertListBodyCubit(mockGeolocateCityRemotely, mockGeolocateCityLocally);
      },
      act: (sut) => sut.geolocateACity('CityName'),
      expect: () => [
        Loading(),
        const FetchFailed(errorMessage: 'An error occured, please contact Admin'),
      ],
    );
  });

  group('local tests - ', () {
    blocTest<ConcertListBodyCubit, ConcertListBodyState>(
      'emits Loading and DataFetched states when geolocateACity is successful',
      build: () {
        when(() => mockGeolocateCityLocally(any())).thenAnswer((_) async => mockGeolocations);
        return ConcertListBodyCubit(mockGeolocateCityRemotely, mockGeolocateCityLocally);
      },
      act: (sut) => sut.geolocateACity('CityName', local: true),
      expect: () => [Loading(), DataFetched(mockGeolocations)],
    );

    blocTest<ConcertListBodyCubit, ConcertListBodyState>(
      'emits Loading and FetchFailed states when geolocateACity throws a ReadingFailure',
      build: () {
        when(() => mockGeolocateCityRemotely(any())).thenThrow(ReadingFailure(key: ''));
        return ConcertListBodyCubit(mockGeolocateCityRemotely, mockGeolocateCityLocally);
      },
      act: (sut) => sut.geolocateACity('CityName', local: true),
      expect: () => [
        Loading(),
        const FetchFailed(errorMessage: 'An error occured, please contact Admin', wasNotFound: true),
      ],
    );
  });
}
