import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bloc/provider/home_screen_state_provider.dart';
import 'founded_location_list_tile.dart';

class FoundedLocationList extends ConsumerWidget {
  const FoundedLocationList({super.key});

  static const borderRadius = 15.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var foundedLocations = ref.watch(
      homeScreenStateProvider.select(
        (state) => state.locationsBySearchQuery,
      ),
    );

    return Visibility(
      visible: foundedLocations.isNotEmpty,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: foundedLocations.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) => FoundedLocationListTile(
            location: foundedLocations[index],
          ),
        ),
      ),
    );
  }
}
