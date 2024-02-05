import 'package:flutter/material.dart';

class TextButtonMolecule extends StatelessWidget {
  const TextButtonMolecule(
      {required this.onPressed, required this.text, super.key});
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
        ));
  }
}
