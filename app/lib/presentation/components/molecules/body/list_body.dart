import 'package:cities/cities.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import '../../../presentation.dart';

class BodyList extends StatelessWidget {
  const BodyList({super.key});

  String _formatCityName(Geolocation city) {
    final cityName = city.localName ?? city.name;
    final hasCountryName = city.country?.isNotEmpty;
    final country = hasCountryName ?? false ? ', ${city.country}' : '';
    return '$cityName$country';
  }

  @override
  Widget build(BuildContext context) {
    final _longestSide = MediaQuery.of(context).size.longestSide;
    return BlocBuilder<ConcertListBodyCubit, ConcertListBodyState>(
      builder: (context, state) {
        final isDataState = state is NextConcerts || state is DataFetched;
        return Material(
          child: ListView.builder(
            restorationId: ConcertListPage.routeName,
            itemCount: isDataState ? state.cities?.length : 1,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                key: Key('item_$index'),
                title: Text(
                  () {
                    if (isDataState) return _formatCityName(state.cities![index]);
                    if (state is FetchFailed) return state.wasNotFound ? 'City not found' : state.errorMessage;
                    if (state is Loading) return 'fetching ...';
                    return '';
                  }(),
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
                leading: Container(
                  padding: EdgeInsets.all(_longestSide * .01),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: FittedBox(
                    child: Icon(FeatherIcons.mapPin, size: _longestSide * 0.05),
                  ),
                ),
                trailing: () {
                  if (state is FetchFailed) return null;
                  return state.cities?[index].isLoading ?? true
                      ? const CircularProgressIndicator.adaptive()
                      : Icon(
                          FeatherIcons.arrowRight,
                          size: MediaQuery.of(context).size.width * 0.06,
                        );
                }(),
                onTap: (state.cities?[index].isLoading ?? true)
                    ? null
                    : () => Navigator.pushNamed(
                          context,
                          WeatherForecastPage.routeName,
                          arguments: WeatherFetchingInput(
                              cityName: state.cities?[index].localName ?? state.cities?[index].name ?? '',
                              latitude: state.cities?[index].lat ?? 0,
                              longitude: state.cities?[index].lon ?? 0),
                        ),
              );
            },
          ),
        );
      },
    );
  }
}
