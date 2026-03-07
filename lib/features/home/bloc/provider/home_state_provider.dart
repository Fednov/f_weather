import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/home_state.dart';
import '../../repository/provider/home_repository_provider.dart';
import '../home_bloc.dart';

final homeStateProvider =
    StateNotifierProvider.autoDispose<HomeBloc, HomeState>((ref) {
  var homeScreenRepository = ref.watch(homeRepositoryProvider);

  var homeScreenBloc = HomeBloc(homeScreenRepository: homeScreenRepository)
    ..init();

  return homeScreenBloc;
});
