import 'package:flutter/material.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    // Return an empty container to remove the default overscroll glow effect
    return Container();
  }
}
