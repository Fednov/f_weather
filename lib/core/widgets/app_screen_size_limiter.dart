import 'package:flutter/material.dart';

class AppScreenSizeLimiter extends StatelessWidget {
  const AppScreenSizeLimiter({
    super.key,
    required this.child,
    this.maxHeight,
    this.maxWidth,
  });

  final Widget? child;
  final double? maxHeight;
  final double? maxWidth;

  static const _defaultMaxWidth = 600.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? double.infinity,
                maxWidth: maxWidth ?? _defaultMaxWidth,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
