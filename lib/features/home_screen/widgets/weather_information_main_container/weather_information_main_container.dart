import 'package:flutter/material.dart';

import '../common/base_weather_information_container.dart';
import 'feels_like_text.dart';
import 'temp_c_text.dart';
import 'weather_condition_text.dart';
import 'weather_icon.dart';

class WeatherInformationMainContainer extends StatelessWidget {
  const WeatherInformationMainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseWeatherInformationContainer(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WeatherIcon(),
                  TempCText(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: WeatherConditionText(),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: FeelsLikeText(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}