import 'package:flutter/material.dart';

enum _Type {
  normal,
  tonal,
}

class FilledButtonAtom extends StatelessWidget {
  const FilledButtonAtom(
      {required this.onPressed, required this.child, super.key})
      : _type = _Type.normal;
  const FilledButtonAtom.tonal(
      {required this.onPressed, required this.child, super.key})
      : _type = _Type.tonal;

  final _Type _type;
  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case _Type.normal:
        return FilledButton(onPressed: onPressed, child: child);

      case _Type.tonal:
        return FilledButton.tonal(onPressed: onPressed, child: child);
      default:
        throw UnimplementedError();
    }
  }
}
