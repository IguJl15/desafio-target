import 'package:flutter/material.dart';

extension ContextThemeData on BuildContext {
  ThemeData get themeData => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
