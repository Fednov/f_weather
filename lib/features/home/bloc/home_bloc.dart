import 'dart:async';

import 'package:async/async.dart';
import 'package:f_weather/core/model/data_state.dart';
import 'package:f_weather/core/model/location_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/home_state.dart';
import '../state/home_status.dart';
import '../repository/home_repository.dart';

class HomeBloc extends StateNotifier<HomeState> {
  HomeBloc({
    required HomeRepository homeScreenRepository,
  })  : _homeScreenRepository = homeScreenRepository,
        super(HomeState());

  final HomeRepository _homeScreenRepository;

  StreamSubscription? _dateTimeStreamSubscription;

  CancelableOperation? _searchLocationOperation;
  CancelableOperation? _searchWeatherOperation;

  Timer? _searchDebounceTimer;
  static const _searchDebounceTimerDuration = Duration(milliseconds: 500);

  final _dateTimeStream = Stream.periodic(
    const Duration(minutes: 1),
  );

  void init() {
    _dateTimeStreamSubscription?.cancel();

    _dateTimeStreamSubscription = _dateTimeStream
        .map((_) => DateTime.now().hour)
        .distinct()
        .listen((_) => onWeatherReload());
  }

  Future<void> onLocationSearchQueryChanged(
      {required String searchQuery}) async {
    _searchDebounceTimer?.cancel();

    _searchDebounceTimer = Timer(
      _searchDebounceTimerDuration,
      () async {
        await _searchLocationOperation?.cancel();

        _searchLocationOperation = CancelableOperation.fromFuture(
          _homeScreenRepository.loadLocationListBySearchQuery(
              searchQuery: searchQuery),
        );

        var searchRequestDataState = await _searchLocationOperation?.value;

        if (_searchLocationOperation?.isCanceled ?? true) {
          return;
        }

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
      },
    );
  }

  Future<void> onWeatherLoad({required String searchQuery}) async {
    await _searchWeatherOperation?.cancel();

    state = state.copyWith(status: const HomeScreenStatusLoading());

    _searchWeatherOperation = CancelableOperation.fromFuture(
      _homeScreenRepository.loadWeather(searchQuery: searchQuery),
    );

    var searchRequestDataState = await _searchWeatherOperation?.value;

    if (_searchWeatherOperation?.isCanceled ?? true) return;

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

    onWeatherLoad(searchQuery: '${location.lat},${location.lon}');
  }

  Future<void> onWeatherReload() async {
    var selectedLocation = state.selectedLocation;

    if (selectedLocation != null) {
      onWeatherLoad(searchQuery: selectedLocation.name);
    }
  }

  void onSearchQueryClear() {
    state = state.copyWith(
      locationsBySearchQuery: [],
    );
  }

  // void _weatherAutoUpdater() {
  //   var lastUpdated = state.lastUpdated;
  //   if (lastUpdated != null) {
  //     if (lastUpdated.hour != DateTime.now().hour) {
  //       onWeatherReloading();
  //     }
  //   }
  // }

  @override
  void dispose() {
    _dateTimeStreamSubscription?.cancel();
    _searchLocationOperation?.cancel();
    _searchWeatherOperation?.cancel();
    _searchDebounceTimer?.cancel();
    super.dispose();
  }
}
