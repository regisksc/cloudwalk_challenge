import 'package:flutter/material.dart';

import '../../../presentation.dart';

class ShowInitialListFab extends StatelessWidget {
  const ShowInitialListFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        final buttonWidth = screenWidth * 0.3;
        final buttonHeight = screenHeight * 0.08;

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
                    width: buttonWidth,
                    height: buttonHeight,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * .02),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        'show next concerts',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(fontSize: screenWidth * 0.04),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
