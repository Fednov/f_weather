import 'package:f_weather/core/extensions/buildcontext_extensions.dart';
import 'package:f_weather/core/utils/weather/weather_convertor_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bloc/provider/home_state_provider.dart';
import 'weather_info_row.dart';

class WeatherInfoRows extends ConsumerWidget {
  const WeatherInfoRows({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var weather = ref.watch(
      homeStateProvider.select((state) => state.weather?.current),
    );

    var size = context.sizeOf();

    return SingleChildScrollView(
      child: Column(
        children: [
          WeatherInfoRow(
            name: 'Скорость ветра',
            value: AppWeatherConvertorUtil.kphToMps(
              kph: weather?.windKph ?? 0,
            ).toStringAsFixed(1),
            unitOfMeasurement: 'м/с',
            metricIcon: Icons.air,
            iconColor: const Color(0xffC01B3C),
          ),
          WeatherInfoRow(
            name: 'Влажность',
            value: '${weather?.humidity}',
            unitOfMeasurement: '%',
            metricIcon: Icons.water_drop,
            iconColor: const Color(0xff379ADC),
          ),
          WeatherInfoRow(
            name: 'Видимость',
            value: '${weather?.visKm}',
            unitOfMeasurement: 'км',
            metricIcon: Icons.visibility,
            iconColor: const Color(0xff1E9B26),
          ),
          WeatherInfoRow(
            name: 'Атмосферное давление',
            value: AppWeatherConvertorUtil.pressureMbToMillimetresOfMercury(
              pressureMb: weather?.pressureMb ?? 0,
            ).toStringAsFixed(1),
            unitOfMeasurement: 'мм.рт.ст',
            metricIcon: Icons.compress,
            iconColor: Colors.indigo,
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
