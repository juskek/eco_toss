import 'package:flutter/material.dart';

class ElevatedButtonAtom extends StatelessWidget {
  const ElevatedButtonAtom(
      {required this.onPressed, required this.child, super.key});

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
