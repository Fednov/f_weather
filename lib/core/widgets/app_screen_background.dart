import 'package:f_weather/core/extensions/string_extension.dart';
import 'package:f_weather/core/utils/constants/app_constants_ui.dart';
import 'package:flutter/material.dart';

class AppScreenBackground extends StatelessWidget {
  const AppScreenBackground({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstantsUi.screenContentPadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color('FEE3BC'.hexColor()),
            Color('F39876'.hexColor()),
          ],
        ),
      ),
      child: SafeArea(
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
