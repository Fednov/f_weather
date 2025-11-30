import 'package:f_weather/core/configs/assets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bloc/provider/home_screen_state_provider.dart';

class WeatherConditionText extends ConsumerWidget {
  const WeatherConditionText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var weather = ref.watch(
      homeScreenStateProvider.select(
        (state) => state.weather?.current,
      ),
    );

    return Text(
      '${weather?.condition?.text}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: AppAssetsFonts.inter,
        fontSize: 14,
      ),
    );
  }
}
