import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/weather.dart';

class MockClient extends Mock implements HttpClient {}

class MockWrite extends Mock implements Write {}

class MockRead extends Mock implements Read {}

class MockWeatherForecast extends Mock implements WeatherForecast {}

class MockFetchCurrentWeather extends Mock implements Usecase<WeatherForecast, WeatherFetchingInput> {}
class MockFetchWeatherForecast extends Mock implements Usecase<List<WeatherForecast>, WeatherFetchingInput> {}

final weatherForecastMock = WeatherForecast(
  modifiedWhen: DateTime.now(),
  tempMax: Temperature(value: 70),
  time: ForecastTime(unixTimestamp: DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000),
  tempMin: Temperature(value: 65),
  weatherDescription: '',
  windSpeed: WindSpeed(value: 5),
);
