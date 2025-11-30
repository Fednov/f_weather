import 'dart:convert';

import 'current_weather_model/current_weather_model.dart';
import 'location_model.dart';

class WeatherModel {
  WeatherModel({
    required this.location,
    required this.current,
  });

  final LocationModel location;
  final CurrentWeatherModel current;

  WeatherModel copyWith({
    LocationModel? location,
    CurrentWeatherModel? current,
  }) {
    return WeatherModel(
      location: location ?? this.location,
      current: current ?? this.current,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location.toMap(),
      'current': current.toMap(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      location: LocationModel.fromMap(map['location']),
      current: CurrentWeatherModel.fromMap(map['current']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherModel &&
        other.location == location &&
        other.current == current;
  }

  @override
  int get hashCode => location.hashCode ^ current.hashCode;

  @override
  String toString() => 'WeatherModel(location: $location, current: $current)';
}
