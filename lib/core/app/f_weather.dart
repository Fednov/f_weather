import 'package:f_weather/core/theme/theme.dart';
import 'package:f_weather/core/utils/constants/app_constants_string.dart';
import 'package:f_weather/core/utils/globals/app_globals.dart';
import 'package:f_weather/features/home_screen/screen/home_screen.dart';
import 'package:flutter/material.dart';


class FWeather extends StatelessWidget {
  const FWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstantsString.appTitle,
      debugShowCheckedModeBanner: false,
      navigatorKey: AppGlobals.navigatorKey,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
