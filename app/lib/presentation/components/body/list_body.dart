import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import '../../presentation.dart';

class BodyList extends StatelessWidget {
  const BodyList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConcertListBodyCubit, ConcertListBodyState>(
      builder: (context, state) {
        return (state is Loading)
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView.builder(
                restorationId: ConcertListPage.routeName,
                itemCount: state is NextConcerts ? state.nextConcertCityNames.length : 1,
                itemBuilder: (BuildContext context, int index) {
                  String tileTitle = '';
                  if (state is NextConcerts) tileTitle = state.nextConcertCityNames[index];
                  if (state is DataFetched) {
                    final cityName = state.cities[index].localName ?? state.cities[index].name;
                    final hasCountryName = state.cities[index].country?.isNotEmpty;
                    final country = hasCountryName ?? false ? ', ${state.cities[index].country}' : '';
                    tileTitle = '$cityName$country';
                  }
                  if (state is FetchFailed) tileTitle = state.errorMessage;

                  return ListTile(
                    title: Text(tileTitle),
                    leading: const CircleAvatar(child: Icon(FeatherIcons.mapPin)),
                    trailing: const Icon(FeatherIcons.arrowRight),
                    onTap: () {
                      Navigator.pushNamed(context, WeatherForecastPage.routeName,
                          arguments: const WeatherFetchingInput(cityName: '', latitude: 0, longitude: 0, locale: ''));
                    },
                  );
                },
              );
      },
    );
  }
}
