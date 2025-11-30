import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bloc/provider/home_screen_state_provider.dart';

class TempCText extends ConsumerWidget {
  const TempCText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var weather = ref.watch(
      homeScreenStateProvider.select(
        (state) => state.weather?.current,
      ),
    );

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        text: TextSpan(
          text: '${weather?.tempC?.round()}',
          style: const TextStyle(
            fontSize: 43,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: const <TextSpan>[
            TextSpan(
              text: '°C',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}