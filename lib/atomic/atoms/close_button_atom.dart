import 'package:flutter/material.dart';

class CloseButtonAtom extends StatelessWidget {
  const CloseButtonAtom(
    this.mainContext, {
    required this.closeCallback,
    this.onClose,
    this.inverted = false,
    super.key,
  });
  final BuildContext mainContext;
  final void Function()? closeCallback;
  final void Function()? onClose;
  final bool inverted;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        closeCallback?.call();
        if (onClose != null) {
          onClose!();
        }
      },
      child: const SizedBox(
        child: Icon(Icons.close),
      ),
    );
  }
}
