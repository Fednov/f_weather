import 'package:f_weather/core/extensions/buildcontext_extensions.dart';
import 'package:f_weather/core/utils/weather/weather_convertor_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bloc/provider/home_screen_state_provider.dart';
import 'common/base_secondary_information_container.dart';

class WeatherInformationSecondaryList extends ConsumerWidget {
  const WeatherInformationSecondaryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var weather = ref.watch(
      homeScreenStateProvider.select((state) => state.weather?.current),
    );

    var size = context.sizeOf();

    return SingleChildScrollView(
      child: Column(
        children: [
          BaseSecondaryInformationContainer(
            name: 'Скорость ветра',
            value: AppWeatherConvertorUtil.kphToMps(
              kph: weather?.windKph ?? 0,
            ).toStringAsFixed(1),
            unitOfMeasurement: 'м/с',
          ),
          BaseSecondaryInformationContainer(
            name: 'Влажность',
            value: '${weather?.humidity}',
            unitOfMeasurement: '%',
          ),
          BaseSecondaryInformationContainer(
            name: 'Видимость',
            value: '${weather?.visKm}',
            unitOfMeasurement: 'км',
          ),
          BaseSecondaryInformationContainer(
            name: 'Атмосферное давление',
            value: AppWeatherConvertorUtil.pressureMbToMillimetresOfMercury(
              pressureMb: weather?.pressureMb ?? 0,
            ).toStringAsFixed(1),
            unitOfMeasurement: 'мм.рт.ст',
          ),
        ]
            .map(
              (element) => Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.01),
                child: element,
              ),
            )
            .toList(),
      ),
    );
  }
}
