import 'package:flutter/material.dart';

import '../../presentation.dart';

class ShowInitialListFab extends StatelessWidget {
  const ShowInitialListFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConcertListBodyCubit, ConcertListBodyState>(
      builder: (context, state) {
        return Visibility(
          visible: state is DataFetched || state is FetchFailed,
          child: InkWell(
            key: const Key('inkwell'),
            onTap: () => context.read<ConcertListBodyCubit>().geolocalizeStartingList(),
            child: Card(
              elevation: 40,
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                alignment: Alignment.center,
                child: Text('show next concerts', style: Theme.of(context).primaryTextTheme.labelMedium),
              ),
            ),
          ),
        );
      },
    );
  }
}
