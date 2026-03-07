import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bloc/provider/home_state_provider.dart';
import '../state/home_status.dart';

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
    ref.listen(homeStateProvider.select((state) => state.status), (prev, next) {
      if (next is HomeScreenStatusLoading) {
        _focusNode.unfocus();
      }
    });

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        height: 48,
        width: 341,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (value) => ref
              .read(homeStateProvider.notifier)
              .onLocationSearchQueryChanged(searchQuery: value),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
                              .read(homeStateProvider.notifier)
                              .onWeatherLoad(searchQuery: _controller.text)
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
    ref.read(homeStateProvider.notifier).onSearchQueryClear();
  }

  void _onFocusNodeHasFocus() {
    if (_controller.text.isNotEmpty) {
      ref.read(homeStateProvider.notifier).onLocationSearchQueryChanged(
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
          : ref.read(homeStateProvider.notifier).onSearchQueryClear(),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
