import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bloc/provider/home_state_provider.dart';
import 'founded_location_list_tile.dart';

class FoundedLocationList extends ConsumerWidget {
  const FoundedLocationList({super.key});

  static const _borderRadius = 15.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var foundedLocations = ref.watch(
      homeStateProvider.select(
        (state) => state.locationsBySearchQuery,
      ),
    );

    return Visibility(
      visible: foundedLocations.isNotEmpty,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_borderRadius),
            bottomRight: Radius.circular(_borderRadius),
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
