import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bloc/provider/home_screen_state_provider.dart';
import '../../model/home_screen_status.dart';
import 'screen_body_error.dart';
import 'screen_body_init.dart';
import 'screen_body_weather_information.dart';

class HomeScreenBodySwitcher extends ConsumerWidget {
  const HomeScreenBodySwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var status =
        ref.watch(homeScreenStateProvider.select((state) => state.status));

    switch (status) {
      case HomeScreenStatusInit():
        return const ScreenBodyInit();
      case HomeScreenStatusLoading():
        return const Center(
          child: CircularProgressIndicator(),
        );
      case HomeScreenStatusSuccess():
        return const ScreenBodyWeatherInformation();
      case HomeScreenStatusError():
        return const ScreenBodyError();

      default:
        return Container();
    }
  }
}
