import 'package:core/core.dart';

import '../../weather.dart';

abstract class FetchCurrentWeather extends Usecase<WeatherForecast, WeatherFetchingInput> {}
