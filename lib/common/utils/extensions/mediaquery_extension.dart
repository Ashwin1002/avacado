import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  double get deviceWidth => MediaQuery.sizeOf(this).width;
  double get deviceHeight => MediaQuery.sizeOf(this).height;
}
