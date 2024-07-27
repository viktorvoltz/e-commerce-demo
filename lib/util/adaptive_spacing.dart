import 'package:flutter/widgets.dart';

extension AdaptiveSpacing on num {
  double get w => this * _widthFactor;
  double get h => this * _heightFactor;

  static double _widthFactor = 1.0;
  static double _heightFactor = 1.0;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _widthFactor = mediaQuery.size.width / 100;
    _heightFactor = mediaQuery.size.height / 100;
  }
}