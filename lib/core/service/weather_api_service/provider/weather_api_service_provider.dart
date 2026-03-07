import 'package:f_weather/core/providers/app_config_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../weather_api_service.dart';

final weatherApiServiceProvider =
    Provider.autoDispose<WeatherApiService>((ref) {
  var apiKey = ref.watch(
    appConfigProvider.select(
      (state) => state.weatherApiApiKey,
    ),
  );

  return WeatherApiService(apiKey: apiKey);
});
