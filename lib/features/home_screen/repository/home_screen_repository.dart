import 'package:f_weather/core/model/data_state.dart';
import 'package:f_weather/core/model/location_model.dart';
import 'package:f_weather/core/model/weather_model.dart';
import 'package:f_weather/core/service/weather_api_service/weather_api_service.dart';

class HomeScreenRepository {
  HomeScreenRepository({
    required WeatherApiService weatherApiService,
  }) : _weatherApiService = weatherApiService;

  final WeatherApiService _weatherApiService;

  Future<DataState<List<LocationModel>>> loadLocationListBySearchQuery({
    required searchQuery,
  }) async {
    return _weatherApiService.loadLocationListBySearchQuery(
      searchQuery: searchQuery,
    );
  }

  Future<DataState<WeatherModel>> loadWeather({
    required searchQuery,
  }) async {
    return _weatherApiService.loadWeather(
      searchQuery: searchQuery,
    );
  }
}
