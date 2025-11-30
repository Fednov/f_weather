import 'package:f_weather/core/configs/assets/fonts.dart';
import 'package:f_weather/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

final class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    fontFamily: AppAssetsFonts.inter,
    scaffoldBackgroundColor: Color(
      '#FFFFFF'.hexColor(),
    ),
  );
}
