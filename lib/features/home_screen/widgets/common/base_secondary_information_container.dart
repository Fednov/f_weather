import 'package:f_weather/core/configs/assets/fonts.dart';
import 'package:f_weather/core/extensions/buildcontext_extensions.dart';
import 'package:flutter/material.dart';

import 'base_weather_information_container.dart';

class BaseSecondaryInformationContainer extends StatelessWidget {
  const BaseSecondaryInformationContainer({
    super.key,
    required this.name,
    required this.value,
    this.unitOfMeasurement,
  });

  final String name;
  final String value;
  final String? unitOfMeasurement;

  static const _textStyle = TextStyle(
    fontFamily: AppAssetsFonts.inter,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    var size = context.sizeOf();

    return SizedBox(
      height: size.height * 0.08,
      child: BaseWeatherInformationContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$name:',
                style: _textStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$value${unitOfMeasurement != null ? ' $unitOfMeasurement' : ''}',
                style: _textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
