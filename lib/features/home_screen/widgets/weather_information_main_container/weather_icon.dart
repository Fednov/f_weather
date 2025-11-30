import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bloc/provider/home_screen_state_provider.dart';

class WeatherIcon extends ConsumerWidget {
  const WeatherIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var weather = ref.watch(
      homeScreenStateProvider.select(
        (state) => state.weather?.current,
      ),
    );

    return Image(
      fit: BoxFit.scaleDown,
      image: NetworkImage(
        _iconUrlFormat(url: '${weather?.condition?.icon}'),
      ),
      errorBuilder: (context, object, stackTrace) {
        log(stackTrace.toString());

        return Container();
      },
    );
  }

  String _iconUrlFormat({required String url}) {
    return 'https:$url';
  }
}
