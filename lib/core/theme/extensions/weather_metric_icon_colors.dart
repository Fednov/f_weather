import 'package:flutter/material.dart';

class WeatherMetricIconColors extends ThemeExtension<WeatherMetricIconColors> {
  final Color humidity;
  final Color wind;
  final Color pressure;
  final Color visibility;

  const WeatherMetricIconColors({
    required this.humidity,
    required this.wind,
    required this.pressure,
    required this.visibility,
  });

  @override
  ThemeExtension<WeatherMetricIconColors> copyWith({
    Color? humidity,
    Color? wind,
    Color? pressure,
    Color? visibility,
  }) {
    return WeatherMetricIconColors(
      humidity: humidity ?? this.humidity,
      wind: wind ?? this.wind,
      pressure: pressure ?? this.pressure,
      visibility: visibility ?? this.visibility,
    );
  }

  static WeatherMetricIconColors of(BuildContext context) {
    return Theme.of(context).extension<WeatherMetricIconColors>()!;
  }

  @override
  ThemeExtension<WeatherMetricIconColors> lerp(
    ThemeExtension<WeatherMetricIconColors>? other,
    double t,
  ) {
    if (other is! WeatherMetricIconColors) return this;
    return WeatherMetricIconColors(
      humidity: Color.lerp(humidity, other.humidity, t)!,
      wind: Color.lerp(wind, other.wind, t)!,
      pressure: Color.lerp(pressure, other.pressure, t)!,
      visibility: Color.lerp(visibility, other.visibility, t)!,
    );
  }
}
