import 'package:flutter/material.dart';

class ButtonTextAtom extends StatelessWidget {
  const ButtonTextAtom(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
      ),
    );
  }
}
