import 'dart:convert';

class WeatherApiResponseError {
  WeatherApiResponseError({
    required this.error,
  });

  final WeatherApiResponseErrorBody error;

  static const Map<int, String> _apiErrors = {
    1002: 'Не предоставлен Api key',
    1003: 'Не указан параметр запроса',
    1005: 'Неправильный Api url',
    1006: 'Нет подходящих локаций',
    2006: 'Предоставленный API key недействителен',
    2007: 'API key превысил месячную квоту вызовов.',
    2008: 'API key был отключен.',
    2009:
        'API key не имеет доступа к ресурсу. \nПожалуйста, ознакомьтесь со страницей ценообразования, \nчтобы узнать, что разрешено в вашем плане подписки на API.',
    9000:
        'Текст Json, переданный в массовом запросе, неверен. \nПожалуйста, убедитесь, что это правильный json в кодировке utf-8.',
    9001:
        'Текст в формате Json содержит слишком много мест для массового запроса. \nПожалуйста, не превышайте 50 в одном запросе.',
    9999: 'Внутренняя ошибка приложения.',
  };

  String errorMessage() =>
      'Код: ${error.code}\n${_apiErrors.containsKey(error.code) ? _apiErrors[error.code] : error.message}';

  Map<String, dynamic> toMap() {
    return {
      'error': error.toMap(),
    };
  }

  factory WeatherApiResponseError.fromMap(Map<String, dynamic> map) {
    return WeatherApiResponseError(
      error: WeatherApiResponseErrorBody.fromMap(map['error']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherApiResponseError.fromJson(String source) =>
      WeatherApiResponseError.fromMap(json.decode(source));

  @override
  String toString() => 'WeatherApiResponseError(error: $error)';
}

class WeatherApiResponseErrorBody {
  WeatherApiResponseErrorBody({
    this.code,
    this.message,
  });

  final int? code;
  final String? message;

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
    };
  }

  factory WeatherApiResponseErrorBody.fromMap(Map<String, dynamic> map) {
    return WeatherApiResponseErrorBody(
      code: map['code']?.toInt(),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherApiResponseErrorBody.fromJson(String source) =>
      WeatherApiResponseErrorBody.fromMap(json.decode(source));

  @override
  String toString() => 'ApiResponseErrorBody(code: $code, message: $message)';
}
