import 'package:f_weather/core/configs/assets/fonts.dart';
import 'package:f_weather/core/extensions/buildcontext_extensions.dart';
import 'package:flutter/material.dart';

import 'common/base_weather_info_bubble.dart';

class WeatherInfoRow extends StatelessWidget {
  const WeatherInfoRow({
    super.key,
    required this.name,
    required this.value,
    this.unitOfMeasurement,
    this.metricIcon,
    this.iconColor,
  });

  final String name;
  final String value;
  final String? unitOfMeasurement;
  final IconData? metricIcon;
  final Color? iconColor;

  static const _textStyle = TextStyle(
    fontFamily: AppAssetsFonts.inter,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    var size = context.sizeOf();

    return SizedBox(
      height: size.height * 0.08,
      child: BaseWeatherInfoBubble(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Row(
                    children: [
                      _MetricIcon(
                        metricIcon: metricIcon,
                        iconColor: iconColor,
                      ),
                      const SizedBox(width: 8),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '$name:',
                          style: _textStyle.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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

class _MetricIcon extends StatelessWidget {
  const _MetricIcon({
    // ignore: unused_element
    super.key,
    this.metricIcon,
    this.iconColor,
  });

  final IconData? metricIcon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Material(
      elevation: 2,
      borderRadius: const BorderRadius.all(Radius.circular(7)),
      shadowColor: theme.shadowColor,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: metricIcon != null
            ? Icon(
                metricIcon,
                color: iconColor,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
