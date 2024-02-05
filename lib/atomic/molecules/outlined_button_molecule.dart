import 'package:flutter/material.dart';

enum _Mode {
  text,
  role,
}

class OutlinedButtonMolecule extends StatelessWidget {
  const OutlinedButtonMolecule.text(
      {required this.onPressed, required this.text, super.key})
      : _mode = _Mode.text;

  const OutlinedButtonMolecule.role(
      {required this.onPressed, required this.text, super.key})
      : _mode = _Mode.role;

  final void Function()? onPressed;
  final String text;
  final _Mode _mode;
  @override
  Widget build(BuildContext context) {
    switch (_mode) {
      case _Mode.text:
        return OutlinedButton(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ));
      case _Mode.role:
        return OutlinedButton(onPressed: onPressed, child: Text(text));
      default:
        throw UnimplementedError();
    }
  }
}
