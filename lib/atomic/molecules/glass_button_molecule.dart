import 'package:eco_toss/atomic/atoms/button_text_atom.dart';
import 'package:eco_toss/atomic/atoms/error_atom.dart';
import 'package:eco_toss/atomic/atoms/glass_atom.dart';
import 'package:eco_toss/atomic/atoms/spacer_atom.dart';
import 'package:flutter/material.dart';

enum _Mode {
  text,
  textIcon,
  placeholder,
}

class GlassButtonMolecule extends StatelessWidget {
  const GlassButtonMolecule.text(
      {required this.text, required this.onPressed, super.key})
      : _mode = _Mode.text,
        icon = null;

  const GlassButtonMolecule.textIcon(
      {required this.text,
      required this.icon,
      required this.onPressed,
      super.key})
      : _mode = _Mode.textIcon;

  /// Creates a placeholder to maintain the same size, but is invisible
  const GlassButtonMolecule.placeholder({super.key})
      : _mode = _Mode.placeholder,
        text = null,
        icon = null,
        onPressed = null;

  final _Mode _mode;

  final String? text;
  final Widget? icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    switch (_mode) {
      case _Mode.text:
        return GlassAtom(
          child: OutlinedButton(
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonTextAtom(text!),
              ],
            ),
          ),
        );

      case _Mode.textIcon:
        return GlassAtom(
          child: OutlinedButton(
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonTextAtom(text!),
                const SpacerAtom.small(),
                icon!,
              ],
            ),
          ),
        );

      case _Mode.placeholder:
        return OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => Colors.transparent),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => Colors.transparent),
          ),
          onPressed: null,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [ButtonTextAtom('')],
          ),
        );

      default:
        return ErrorAtom.icon;
    }
  }
}
