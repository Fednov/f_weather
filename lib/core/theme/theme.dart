import 'package:f_weather/core/configs/assets/fonts.dart';
import 'package:flutter/material.dart';

import 'extensions/weather_metric_icon_colors.dart';

final class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    fontFamily: AppAssetsFonts.inter,
    scaffoldBackgroundColor: const Color(
      0xffFFFFFF,
    ),
    shadowColor: Colors.grey,
    extensions: const [
      WeatherMetricIconColors(
        humidity: Color(0xff379ADC),
        wind: Color(0xffC01B3C),
        pressure: Color(0xffFFCC80),
        visibility: Color(0xff1E9B26),
      ),
    ],
  );
}
