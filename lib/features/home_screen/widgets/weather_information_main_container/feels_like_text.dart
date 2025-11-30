import 'package:f_weather/core/configs/assets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bloc/provider/home_screen_state_provider.dart';

class FeelsLikeText extends ConsumerWidget {
  const FeelsLikeText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var weather = ref.watch(
      homeScreenStateProvider.select(
        (state) => state.weather?.current,
      ),
    );

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'Ощущается как ${weather?.feelslikeC} °C',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: AppAssetsFonts.inter,
          fontSize: 14,
        ),
      ),
    );
  }
}