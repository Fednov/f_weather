import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bloc/provider/home_screen_state_provider.dart';
import '../model/home_screen_status.dart';

class LocationSearchTextField extends ConsumerStatefulWidget {
  const LocationSearchTextField({super.key});

  @override
  ConsumerState<LocationSearchTextField> createState() =>
      _LocationSearchTextFieldState();
}

class _LocationSearchTextFieldState
    extends ConsumerState<LocationSearchTextField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var status =
        ref.watch(homeScreenStateProvider.select((state) => state.status));

    if (status is HomeScreenStatusLoading) {
      _focusNode.unfocus();
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        height: 48,
        width: 341,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (value) => ref
              .read(homeScreenStateProvider.notifier)
              .onSearchQueryChanged(searchQuery: value),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: 'Поиск',
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
            ),
            alignLabelWithHint: true,
            prefixIcon: const Icon(
              Icons.search,
            ),
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: _onTextFieldClear,
                  icon: const Icon(
                    Icons.clear,
                  ),
                ),
                const Text('|'),
                IconButton(
                  onPressed: () =>
                      (_controller.text.isNotEmpty && _focusNode.hasFocus)
                          ? ref
                              .read(homeScreenStateProvider.notifier)
                              .onWeatherLoading(searchQuery: _controller.text)
                          : null,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTextFieldClear() {
    _controller.clear();
    ref.read(homeScreenStateProvider.notifier).onSearchQueryClear();
  }

  void _onFocusNodeHasFocus() {
    if (_controller.text.isNotEmpty) {
      ref.read(homeScreenStateProvider.notifier).onSearchQueryChanged(
            searchQuery: _controller.text,
          );
    }
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(
      () => _focusNode.hasFocus
          ? _onFocusNodeHasFocus()
          : ref.read(homeScreenStateProvider.notifier).onSearchQueryClear(),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
