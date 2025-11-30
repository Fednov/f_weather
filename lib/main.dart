import 'package:f_weather/core/app/f_weather.dart';
import 'package:f_weather/core/utils/system_functions/app_system_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSystemFunctions.adjustSystemUiOverlay();
  await AppSystemFunctions.setPrefferedOrientations();
  runApp(
    const ProviderScope(
      child: FWeather(),
    ),
  );
}
