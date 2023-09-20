import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

class MockClient extends Mock implements HttpClient {}

class MockWrite extends Mock implements Write {}

class MockRead extends Mock implements Read {}

class MockWeatherForecast extends Mock implements WeatherForecast {}
