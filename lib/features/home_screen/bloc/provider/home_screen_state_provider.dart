import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/home_screen_state.dart';
import '../../repository/provider/home_screen_repository_provider.dart';
import '../home_screen_bloc.dart';

final homeScreenStateProvider =
    StateNotifierProvider.autoDispose<HomeScreenBloc, HomeScreenState>((ref) {
  final homeScreenRepository = ref.watch(homeScreenRepositoryProvider);

  return HomeScreenBloc(homeScreenRepository: homeScreenRepository);
});
