import 'package:f_weather/core/configs/assets/fonts.dart';
import 'package:f_weather/core/extensions/datetime_extensions.dart';
import 'package:f_weather/features/home_screen/bloc/provider/home_screen_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationNameContainer extends ConsumerWidget {
  const LocationNameContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var location = ref.watch(
      homeScreenStateProvider.select(
        (state) => state.weather?.location,
      ),
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${location?.name},\n${location?.country}',
              style: const TextStyle(
                fontFamily: AppAssetsFonts.inter,
                fontSize: 24,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              DateTime.parse(location?.localtime ?? '').formattedDate(),
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
