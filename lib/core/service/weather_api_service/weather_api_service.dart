import 'dart:convert';

import 'package:f_weather/core/model/data_state.dart';
import 'package:f_weather/core/model/location_model.dart';
import 'package:f_weather/core/model/weather_model.dart';
import 'package:f_weather/core/utils/constants/app_constants_keys.dart';
import 'package:f_weather/core/utils/system_functions/app_system_functions.dart';
import 'package:http/http.dart' as http;

import 'weather_api_response_error.dart';

class WeatherApiService {
  const WeatherApiService();

  Future<DataState<List<LocationModel>>> loadLocationListBySearchQuery({
    required String searchQuery,
  }) async {
    var url =
        'https://api.weatherapi.com/v1/search.json?key=${AppConstantsKeys.apiKey}&q=$searchQuery&lang=ru';

    try {
      var response = await http.get(Uri.parse(url));

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
      return DataFailed(message: error.toString());
    }
  }

  Future<DataState<WeatherModel>> loadWeather({
    required String searchQuery,
  }) async {
    var url =
        'https://api.weatherapi.com/v1/current.json?key=${AppConstantsKeys.apiKey}&q=$searchQuery&lang=ru';

    try {
      var response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          return http.Response(
            _timeOutErrorResponseBody(),
            408,
          );
        },
      );

      if (response.statusCode == 200) {
        var weatherModel = WeatherModel.fromJson(response.body);

        return DataSuccess(data: weatherModel);
      }

      return DataFailed(
        message: WeatherApiResponseError.fromJson(response.body).errorMessage(),
      );
    } catch (error) {
      AppSystemFunctions.showSnackBarGlobal(content: error.toString());
      return DataFailed(message: error.toString());
    }
  }

  String _timeOutErrorResponseBody() => WeatherApiResponseError(
        error: WeatherApiResponseErrorBody(
            code: 408, message: 'Connection Timeout'),
      ).toJson();
}
