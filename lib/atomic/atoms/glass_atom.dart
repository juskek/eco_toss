import 'dart:ui';

import 'package:flutter/material.dart';

class GlassAtom extends StatelessWidget {
  const GlassAtom({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: child,
      ),
    );
  }
}
