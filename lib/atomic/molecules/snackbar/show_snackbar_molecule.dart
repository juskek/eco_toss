import 'package:flutter/material.dart';

/// Shows a snackbar notification in the current material app
///
/// * Action can be provided via actionLabel and actionOnPressed. If null, then default action is Dismiss
///
/// * If showing snackbar on top of a showDialogMolecule, ensure dialogScaffoldMessengerKey is provided to the showDialogMolecule
void showSnackbarMolecule(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    {required String message,
    String? actionLabel,
    void Function()? actionOnPressed}) {
  scaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      action: SnackBarAction(
        label: actionLabel ?? 'Dismiss',
        onPressed: actionOnPressed ??
            () => scaffoldMessengerKey.currentState!.hideCurrentSnackBar(),
      ),
    ),
  );
}
