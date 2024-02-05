import 'package:flutter/material.dart';

enum _Mode {
  normal,
  fab,
  elevatedButton,
}

class CircularProgressIndicatorAtom extends StatelessWidget {
  const CircularProgressIndicatorAtom({super.key})
      : _mode = _Mode.normal,
        size = null,
        color = null;
  const CircularProgressIndicatorAtom.fab({super.key})
      : _mode = _Mode.fab,
        size = 15,
        color = Colors.white;
  const CircularProgressIndicatorAtom.elevatedButton({super.key})
      : _mode = _Mode.elevatedButton,
        size = 15,
        color = Colors.white;

  final _Mode _mode;

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    switch (_mode) {
      case _Mode.normal:
        return const CircularProgressIndicator();
      case _Mode.elevatedButton:
        return SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(color: color, strokeWidth: 2),
        );
      case _Mode.fab:
        return SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(color: color, strokeWidth: 2),
        );

      default:
        throw UnimplementedError();
    }
  }
}
