import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../weather_api_service.dart';

final weatherApiServiceProvider = Provider.autoDispose<WeatherApiService>(
  (ref) => const WeatherApiService(),
);
