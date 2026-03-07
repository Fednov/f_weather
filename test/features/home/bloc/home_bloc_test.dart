import 'package:f_weather/core/model/current_weather_model/current_weather_model.dart';
import 'package:f_weather/core/model/data_state.dart';
import 'package:f_weather/core/model/location_model.dart';
import 'package:f_weather/core/model/weather_model.dart';
import 'package:f_weather/features/home/bloc/home_bloc.dart';
import 'package:f_weather/features/home/repository/home_repository.dart';
import 'package:f_weather/features/home/state/home_state.dart';
import 'package:f_weather/features/home/state/home_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_async/fake_async.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

void main() {
  late MockHomeRepository mockRepository;
  late HomeBloc homeBloc;

  final tLocation = LocationModel(
    name: 'London',
    lat: 51.5,
    lon: -0.1,
    country: 'UK',
  );

  final tWeather = WeatherModel(
    location: tLocation,
    current: CurrentWeatherModel(tempC: 15.0),
  );

  setUpAll(() {
    registerFallbackValue(FakeLocationModel());
  });

  setUp(() {
    mockRepository = MockHomeRepository();
    homeBloc = HomeBloc(homeScreenRepository: mockRepository);
  });

  group('HomeBloc Tests', () {
    stateNotifierTest<HomeBloc, HomeState>(
      'onLocationSearchQueryChanged executes search after 500ms debounce',
      build: () => homeBloc,
      setUp: () {
        when(() => mockRepository.loadLocationListBySearchQuery(
              searchQuery: any(named: 'searchQuery'),
            )).thenAnswer((_) async => DataSuccess(data: [tLocation]));
      },
      actions: (bloc) => fakeAsync((async) {
        bloc.onLocationSearchQueryChanged(searchQuery: 'Lon');
        async.elapse(const Duration(milliseconds: 500));
      }),
      expect: () => [
        isA<HomeState>()
            .having((s) => s.locationsBySearchQuery, 'list', [tLocation]),
      ],
    );

    stateNotifierTest<HomeBloc, HomeState>(
      'onLocationSearchQueryClear clears result list',
      build: () => homeBloc,
      seed: () => [
        HomeState(locationsBySearchQuery: [tLocation])
      ],
      actions: (bloc) => bloc.onSearchQueryClear(),
      expect: () => [
        isA<HomeState>()
            .having((s) => s.locationsBySearchQuery, 'list', [tLocation]),
        isA<HomeState>()
            .having((s) => s.locationsBySearchQuery, 'list', isEmpty),
      ],
    );

    stateNotifierTest<HomeBloc, HomeState>(
      'onWeatherLoad sets error status when DataFailed occurs',
      build: () => homeBloc,
      setUp: () {
        when(() => mockRepository.loadWeather(
                searchQuery: any(named: 'searchQuery')))
            .thenAnswer((_) async => DataFailed(message: 'Server Error'));
      },
      actions: (bloc) => bloc.onWeatherLoad(searchQuery: 'London'),
      expect: () => [
        isA<HomeState>()
            .having((s) => s.status, 'status', isA<HomeScreenStatusLoading>()),
        isA<HomeState>().having(
            (s) => s.status.errorMessage, 'error message', 'Server Error'),
      ],
    );

    stateNotifierTest<HomeBloc, HomeState>(
      'onWeatherLoad successfully updates state with weather data',
      build: () => homeBloc,
      setUp: () {
        when(() => mockRepository.loadWeather(
                searchQuery: any(named: 'searchQuery')))
            .thenAnswer((_) async => DataSuccess(data: tWeather));
      },
      actions: (bloc) => bloc.onWeatherLoad(searchQuery: 'London'),
      expect: () => [
        isA<HomeState>()
            .having((s) => s.status, 'status', isA<HomeScreenStatusLoading>()),
        isA<HomeState>()
            .having((s) => s.status, 'status', isA<HomeScreenStatusSuccess>())
            .having((s) => s.weather, 'weather', tWeather)
            .having((s) => s.selectedLocation, 'location', tLocation)
            .having((s) => s.lastUpdated, 'timestamp', isNotNull),
      ],
    );

    test('onLocationSearchQueryChanged cancels previous timer on rapid input',
        () {
      fakeAsync((async) {
        when(() => mockRepository.loadLocationListBySearchQuery(
                searchQuery: any(named: 'searchQuery')))
            .thenAnswer((_) async => DataSuccess(data: [tLocation]));

        homeBloc.onLocationSearchQueryChanged(searchQuery: 'L');
        async.elapse(const Duration(milliseconds: 200));

        homeBloc.onLocationSearchQueryChanged(searchQuery: 'Lo');
        async.elapse(const Duration(milliseconds: 500));

        verify(() =>
                mockRepository.loadLocationListBySearchQuery(searchQuery: 'Lo'))
            .called(1);
        verifyNever(() =>
            mockRepository.loadLocationListBySearchQuery(searchQuery: 'L'));
      });
    });

    stateNotifierTest<HomeBloc, HomeState>(
      'init() triggers weather reload on periodic stream tick',
      build: () => homeBloc,
      seed: () => [HomeState(selectedLocation: tLocation)],
      setUp: () {
        when(() => mockRepository.loadWeather(
                searchQuery: any(named: 'searchQuery')))
            .thenAnswer((_) async => DataSuccess(data: tWeather));
      },
      actions: (bloc) => fakeAsync((async) {
        bloc.init();
        async.elapse(const Duration(minutes: 1));
      }),
      verify: (_) {
        verify(() => mockRepository.loadWeather(searchQuery: tLocation.name))
            .called(1);
      },
    );

    test('dispose() cancels all subscriptions and operations', () {
      homeBloc.dispose();
      expect(() => homeBloc.onSearchQueryClear(), throwsStateError);
    });
  });
}

// Мокаем репозиторий
class MockHomeRepository extends Mock implements HomeRepository {}

// Fake для регистрации в mocktail
class FakeLocationModel extends Fake implements LocationModel {}
