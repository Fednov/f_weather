import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bloc/provider/home_state_provider.dart';

class ScreenBodyError extends ConsumerWidget {
  const ScreenBodyError({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var errorMessage = ref.watch(
      homeStateProvider.select(
        (state) => state.status.errorMessage,
      ),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            'Произошла ошибка\n${errorMessage ?? ''}',
            textAlign: TextAlign.center,
          ),
          IconButton(
            onPressed: ref.watch(homeStateProvider.notifier).onWeatherReload,
            icon: const Icon(Icons.replay_rounded),
          )
        ],
      ),
    );
  }
}
