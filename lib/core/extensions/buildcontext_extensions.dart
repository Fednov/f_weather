import 'package:flutter/material.dart';

extension BuildcontextExtension on BuildContext {
  ThemeData themeOf() {
    return Theme.of(this);
  }

  Size sizeOf() {
    return MediaQuery.of(this).size;
  }
}
