import 'package:flutter/material.dart';

class PaddingAtom extends StatelessWidget {
  const PaddingAtom({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
