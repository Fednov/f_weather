import 'dart:async';

import 'package:f_weather/core/model/data_state.dart';
import 'package:f_weather/core/model/location_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/home_screen_state.dart';
import '../model/home_screen_status.dart';
import '../repository/home_screen_repository.dart';

class HomeScreenBloc extends StateNotifier<HomeScreenState> {
  HomeScreenBloc({
    required HomeScreenRepository homeScreenRepository,
  })  : _homeScreenRepository = homeScreenRepository,
        super(HomeScreenState()) {
    _dateTimeStreamSubscription =
        _dateTimeStream.listen((value) => _weatherAutoUpdater());
  }

  final HomeScreenRepository _homeScreenRepository;

  late StreamSubscription _dateTimeStreamSubscription;

  final _dateTimeStream = Stream.periodic(
    const Duration(minutes: 1),
  );

  Future<void> onSearchQueryChanged({required String searchQuery}) async {
    var searchRequestDataState =
        await _homeScreenRepository.loadLocationListBySearchQuery(
      searchQuery: searchQuery,
    );

    if (searchRequestDataState is DataFailed) {
      state = state.copyWith(
        locationsBySearchQuery: [],
      );
    }

    if (searchRequestDataState is DataSuccess) {
      var locationsBySearchQuery = searchRequestDataState.data;

      state = state.copyWith(
        locationsBySearchQuery: locationsBySearchQuery,
      );
    }
  }

  Future<void> onWeatherLoading({required String searchQuery}) async {
    state = state.copyWith(status: const HomeScreenStatusLoading());

    var searchRequestDataState = await _homeScreenRepository.loadWeather(
      searchQuery: searchQuery,
    );

    if (searchRequestDataState is DataFailed) {
      state = state.copyWith(
        status: HomeScreenStatusError(
          errorMessage: searchRequestDataState.message,
        ),
      );
    }

    if (searchRequestDataState is DataSuccess) {
      var weather = searchRequestDataState.data;

      state = state.copyWith(
        weather: weather,
        selectedLocation: weather?.location,
        lastUpdated: DateTime.now(),
        status: const HomeScreenStatusSuccess(),
      );
    }
  }

  Future<void> onLocationSelect({required LocationModel location}) async {
    state = state.copyWith(
      selectedLocation: location,
      locationsBySearchQuery: [],
    );

    onWeatherLoading(searchQuery: '${location.lat},${location.lon}');
  }

  Future<void> onWeatherReloading() async {
    var selectedLocation = state.selectedLocation;

    if (selectedLocation != null) {
      onWeatherLoading(searchQuery: selectedLocation.name);
    }
  }

  void onSearchQueryClear() {
    state = state.copyWith(
      locationsBySearchQuery: [],
    );
  }

  void _weatherAutoUpdater() {
    var lastUpdated = state.lastUpdated;
    if (lastUpdated != null) {
      if (lastUpdated.hour != DateTime.now().hour) {
        onWeatherReloading();
      }
    }
  }

  @override
  void dispose() {
    _dateTimeStreamSubscription.cancel();

    super.dispose();
  }
}
