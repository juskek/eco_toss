import 'package:flutter/material.dart';

class CardAtom extends StatelessWidget {
  const CardAtom({required this.child, this.color, super.key});
  final Widget child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: child,
    );
  }
}
