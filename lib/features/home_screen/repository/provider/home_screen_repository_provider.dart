import 'package:f_weather/core/service/weather_api_service/provider/weather_api_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../home_screen_repository.dart';

final homeScreenRepositoryProvider = Provider.autoDispose<HomeScreenRepository>((ref) {
  var weatherApiService = ref.watch(weatherApiServiceProvider);

  return HomeScreenRepository(weatherApiService: weatherApiService);
});
