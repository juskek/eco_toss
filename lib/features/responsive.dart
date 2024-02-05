import 'dart:io' show Platform;

import 'package:flutter/material.dart';

abstract class Responsive {
  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static double keyboardHeight(BuildContext context) {
    final viewInsets = EdgeInsets.fromWindowPadding(
        WidgetsBinding.instance.window.viewInsets,
        WidgetsBinding.instance.window.devicePixelRatio);

    return viewInsets.bottom;
  }

  static bool isKeyboardOpen(BuildContext context) {
    return !(WidgetsBinding.instance.window.viewInsets.bottom == 0);
  }

  static double percentWidth(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent / 100;
  }

  static double percentHeight(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent / 100;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
