import 'package:flutter/material.dart';


import '../common/base_weather_info_bubble.dart';
import 'feels_like_text.dart';
import 'temp_c_text.dart';
import 'weather_metric_text.dart';
import 'weather_icon.dart';

class WeatherInfoMainContainer extends StatelessWidget {
  const WeatherInfoMainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseWeatherInfoBubble(
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
                    child: WeatherMetricText(),
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
