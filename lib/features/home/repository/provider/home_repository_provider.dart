import 'package:f_weather/core/service/weather_api_service/provider/weather_api_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home_repository.dart';

final homeRepositoryProvider =
    Provider.autoDispose<HomeRepository>((ref) {
  var weatherApiService = ref.watch(weatherApiServiceProvider);

  return HomeRepository(weatherApiService: weatherApiService);
});
