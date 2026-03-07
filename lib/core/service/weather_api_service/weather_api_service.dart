import 'dart:convert';
import 'dart:developer';

import 'package:f_weather/core/model/data_state.dart';
import 'package:f_weather/core/model/location_model.dart';
import 'package:f_weather/core/model/weather_model.dart';
import 'package:http/http.dart' as http;

import 'weather_api_response_error.dart';

class WeatherApiService {
  const WeatherApiService({
    required String apiKey,
  }) : _apiKey = apiKey;

  final String _apiKey;

  static const _baseUrl = 'api.weatherapi.com';
  static const _locationsPath = '/v1/search.json';
  static const _currentPath = '/v1/current.json';

  Future<DataState<List<LocationModel>>> loadLocationListBySearchQuery({
    required String searchQuery,
  }) async {
    final url = Uri.https(_baseUrl, _locationsPath, {
      'key': _apiKey,
      'q': searchQuery,
      'lang': 'ru',
    });

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var parsedResponseBody = jsonDecode(response.body);

        var locationModelList = (parsedResponseBody as List<dynamic>)
            .map(
              (element) => LocationModel.fromMap(element),
            )
            .toList();

        return DataSuccess(data: locationModelList);
      }

      return DataFailed(
        message: '',
      );
    } catch (error) {
      log(error.toString());
      return DataFailed(message: error.toString());
    }
  }

  Future<DataState<WeatherModel>> loadWeather({
    required String searchQuery,
  }) async {
    var url = Uri.https(_baseUrl, _currentPath, {
      'key': _apiKey,
      'q': searchQuery,
      'lang': 'ru',
    });

    try {
      var response = await http.get(url).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          return http.Response(
            _timeOutErrorResponseBody(),
            408,
          );
        },
      );

      if (response.statusCode == 200) {
        log(response.body);
        var weatherModel = WeatherModel.fromJson(response.body);

        return DataSuccess(data: weatherModel);
      }

      return DataFailed(
        message: WeatherApiResponseError.fromJson(response.body).errorMessage(),
      );
    } catch (error) {
      log(error.toString());
      return DataFailed(message: error.toString());
    }
  }

  String _timeOutErrorResponseBody() => WeatherApiResponseError(
        error: WeatherApiResponseErrorBody(
            code: 408, message: 'Connection Timeout'),
      ).toJson();
}
