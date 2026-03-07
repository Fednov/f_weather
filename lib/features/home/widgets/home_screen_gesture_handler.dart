import 'package:f_weather/features/home/bloc/provider/home_state_provider.dart';
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
      onTap: ref.read(homeStateProvider.notifier).onSearchQueryClear,
      child: child,
    );
  }
}
