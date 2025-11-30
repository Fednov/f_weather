import 'package:f_weather/core/extensions/buildcontext_extensions.dart';
import 'package:flutter/material.dart';

import '../location_name_container.dart';
import '../weather_information_main_container/weather_information_main_container.dart';
import '../weather_information_secondary_list.dart';

class ScreenBodyWeatherInformation extends StatelessWidget {
  const ScreenBodyWeatherInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = context.sizeOf();
    var mainInformationContainerHeight = size.height * 0.172;
    var containerPadding = size.height * 0.01;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: mainInformationContainerHeight,
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: LocationNameContainer(),
            ),
          ),
          SizedBox(
            height: containerPadding,
          ),
          SizedBox(
            height: mainInformationContainerHeight,
            child: const WeatherInformationMainContainer(),
          ),
          SizedBox(
            height: containerPadding * 2,
          ),
          const WeatherInformationSecondaryList()
        ],
      ),
    );
  }
}
