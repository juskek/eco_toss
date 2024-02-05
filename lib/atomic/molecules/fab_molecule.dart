import 'package:eco_toss/atomic/atoms/button_text_atom.dart';
import 'package:eco_toss/atomic/atoms/circular_progress_indicator_atom.dart';
import 'package:eco_toss/atomic/atoms/error_atom.dart';
import 'package:eco_toss/atomic/atoms/spacer_atom.dart';
import 'package:flutter/material.dart';

enum _Mode {
  text,
  textIcon,
  loading,
  placeholder,
}

class FABMolecule extends StatelessWidget {
  const FABMolecule.text(
      {required this.text, required this.onPressed, super.key})
      : _mode = _Mode.text,
        icon = null;

  const FABMolecule.textIcon(
      {required this.text,
      required this.icon,
      required this.onPressed,
      super.key})
      : _mode = _Mode.textIcon;

  const FABMolecule.loading(this.text, {super.key})
      : _mode = _Mode.loading,
        icon = null,
        onPressed = null;

  /// Creates a placeholder to maintain the same size, but is invisible
  const FABMolecule.placeholder({super.key})
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
        return FloatingActionButton.extended(
          heroTag: null,
          onPressed: onPressed,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonTextAtom(text!),
            ],
          ),
        );
      case _Mode.textIcon:
        return FloatingActionButton.extended(
          heroTag: null,
          label: Row(
            children: [
              ButtonTextAtom(text!),
              const SpacerAtom.small(),
              icon!,
            ],
          ),
          onPressed: onPressed,
        );
      case _Mode.loading:
        return FloatingActionButton.extended(
          heroTag: null,
          onPressed: null,
          label: Row(
            children: [
              ButtonTextAtom(text!),
              const SpacerAtom.small(),
              const CircularProgressIndicatorAtom.fab(),
            ],
          ),
        );
      case _Mode.placeholder:
        return const FloatingActionButton.extended(
          heroTag: null,
          onPressed: null,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonTextAtom(''),
            ],
          ),
        );
      default:
        return ErrorAtom.icon;
    }
  }
}
