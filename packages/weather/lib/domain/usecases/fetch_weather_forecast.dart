import 'package:core/core.dart';

import '../../weather.dart';

abstract class FetchWeatherForecast extends Usecase<List<WeatherForecast>, WeatherFetchingInput> {}
