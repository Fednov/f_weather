import 'package:f_weather/core/model/location_model.dart';
import 'package:f_weather/core/model/weather_model.dart';
import 'package:flutter/foundation.dart';

import 'home_screen_status.dart';

class HomeScreenState {
  HomeScreenState({
    this.weather,
    this.selectedLocation,
    this.locationsBySearchQuery = const [],
    this.status = const HomeScreenStatusInit(),
    this.lastUpdated,
  });

  final WeatherModel? weather;
  final LocationModel? selectedLocation;
  final List<LocationModel> locationsBySearchQuery;
  final HomeScreenStatus status;
  final DateTime? lastUpdated;

  HomeScreenState copyWith({
    WeatherModel? weather,
    LocationModel? selectedLocation,
    List<LocationModel>? locationsBySearchQuery,
    HomeScreenStatus? status,
    DateTime? lastUpdated,
  }) {
    return HomeScreenState(
      weather: weather ?? this.weather,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      locationsBySearchQuery: locationsBySearchQuery ?? this.locationsBySearchQuery,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HomeScreenState &&
      other.weather == weather &&
      other.selectedLocation == selectedLocation &&
      listEquals(other.locationsBySearchQuery, locationsBySearchQuery) &&
      other.status == status &&
      other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return weather.hashCode ^
      selectedLocation.hashCode ^
      locationsBySearchQuery.hashCode ^
      status.hashCode ^
      lastUpdated.hashCode;
  }

  @override
  String toString() {
    return 'HomeScreenState(weather: $weather, selectedLocation: $selectedLocation, locationsBySearchQuery: $locationsBySearchQuery, status: $status, lastUpdated: $lastUpdated)';
  }
}
