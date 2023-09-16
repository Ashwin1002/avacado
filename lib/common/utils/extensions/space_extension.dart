import 'package:flutter/widgets.dart';

extension SpaceExtensiion on double {
  SizedBox get spaceX => SizedBox(width: this);
  SizedBox get spaceY => SizedBox(height: this);
}
