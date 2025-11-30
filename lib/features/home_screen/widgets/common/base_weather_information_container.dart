import 'package:flutter/material.dart';

class BaseWeatherInformationContainer extends StatelessWidget {
  const BaseWeatherInformationContainer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
