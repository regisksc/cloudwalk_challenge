import 'package:cities/cities.dart';
import 'package:cloudwalk_challenge/presentation/presentation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';

class MockConcertListBodyCubit extends Mock implements ConcertListBodyCubit {}

class MockGeolocateCity extends Mock implements Usecase<List<Geolocation>, GeolocationInput> {}

class MockConnectivity extends Mock implements Connectivity {}
