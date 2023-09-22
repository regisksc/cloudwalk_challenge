import 'package:cities/cities.dart';
import 'package:faker/faker.dart';

final geolocationInputMock = GeolocationInput(cityName: faker.address.city());
final geolocationMapper = GeolocationMapper(
  name: "Example City",
  lat: 12.345,
  lon: 67.890,
  localName: "{'en': 'Example City'}",
  country: "Example Country",
  state: "Example State",
);
