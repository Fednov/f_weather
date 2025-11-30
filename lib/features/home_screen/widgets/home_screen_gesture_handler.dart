import 'package:f_weather/features/home_screen/bloc/provider/home_screen_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenGestureHandler extends ConsumerWidget {
  const HomeScreenGestureHandler({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: ref.read(homeScreenStateProvider.notifier).onSearchQueryClear,
      child: child,
    );
  }
}
