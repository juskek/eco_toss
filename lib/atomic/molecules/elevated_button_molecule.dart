import 'package:eco_toss/atomic/atoms/button_text_atom.dart';
import 'package:eco_toss/atomic/atoms/circular_progress_indicator_atom.dart';
import 'package:eco_toss/atomic/atoms/spacer_atom.dart';
import 'package:flutter/material.dart';

enum _Mode {
  auth,
  text,
  textIcon,
  loading,
}

class ElevatedButtonMolecule extends StatelessWidget {
  // Show high contrast button required for Sign in with Apple/Google
  const ElevatedButtonMolecule.auth(
      {required this.onPressed, required this.text, this.icon, super.key})
      : _mode = _Mode.auth,
        expanded = true;
  const ElevatedButtonMolecule.text(
      {required this.onPressed,
      required this.text,
      this.expanded = false,
      super.key})
      : _mode = _Mode.text,
        icon = null;
  const ElevatedButtonMolecule.loading(
      {required this.onPressed,
      required this.text,
      this.expanded = false,
      super.key})
      : _mode = _Mode.loading,
        icon = null;
  const ElevatedButtonMolecule.textIcon(
      {required this.onPressed,
      required this.text,
      required this.icon,
      this.expanded = false,
      super.key})
      : _mode = _Mode.textIcon;

  final _Mode _mode;
  final void Function()? onPressed;
  final String text;
  final Widget? icon;

  /// If true, button expands to fill parent
  final bool expanded;
  @override
  Widget build(BuildContext context) {
    switch (_mode) {
      case _Mode.auth:
        final lightMode =
            MediaQuery.of(context).platformBrightness == Brightness.light;
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: lightMode ? Colors.black : Colors.white,
            foregroundColor: lightMode ? Colors.white : Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (icon != null) icon!,
                if (expanded) const SpacerAtom.expanded(),
                ButtonTextAtom(text),
                if (expanded) const SpacerAtom.expanded(),
              ],
            ),
          ),
        );
      case _Mode.text:
        return ElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTextAtom(text),
              ],
            ),
          ),
        );
      case _Mode.textIcon:
        return ElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ButtonTextAtom(text),
                if (expanded) const SpacerAtom.expanded(),
                icon!,
              ],
            ),
          ),
        );
      case _Mode.loading:
        return ElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ButtonTextAtom(text),
                if (expanded) const SpacerAtom.expanded(),
                const CircularProgressIndicatorAtom.elevatedButton(),
              ],
            ),
          ),
        );
      default:
        throw UnimplementedError();
    }
  }
}
