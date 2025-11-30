import 'package:f_weather/core/model/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bloc/provider/home_screen_state_provider.dart';

class FoundedLocationListTile extends ConsumerWidget {
  const FoundedLocationListTile({
    super.key,
    required this.location,
  });

  final LocationModel location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () => ref
          .read(homeScreenStateProvider.notifier)
          .onLocationSelect(location: location),
      title: Text('${location.name}(${location.region}, ${location.country})'),
    );
  }
}
