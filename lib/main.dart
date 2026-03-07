import 'package:f_weather/core/app/f_weather.dart';
import 'package:f_weather/core/model/app_config.dart';
import 'package:f_weather/core/providers/app_config_provider.dart';
import 'package:f_weather/core/utils/constants/app_constants_keys.dart';
import 'package:f_weather/core/utils/system_functions/app_system_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var weatherApiApiKey =
      const String.fromEnvironment(AppConstantsKeys.weatherApiApiKey);

  await AppSystemFunctions.adjustSystemUiOverlay();
  await AppSystemFunctions.setPrefferedOrientations();
  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          AppConfig(
            weatherApiApiKey: weatherApiApiKey,
          ),
        )
      ],
      child: const FWeather(),
    ),
  );
}
