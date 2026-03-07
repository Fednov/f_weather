import 'package:f_weather/core/configs/assets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bloc/provider/home_state_provider.dart';

class WeatherMetricText extends ConsumerWidget {
  const WeatherMetricText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var weather = ref.watch(
      homeStateProvider.select(
        (state) => state.weather?.current,
      ),
    );

    return Text(
      '${weather?.condition?.text}',
      textAlign: TextAlign.center,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: AppAssetsFonts.inter,
        fontSize: 14,
      ),
    );
  }
}
