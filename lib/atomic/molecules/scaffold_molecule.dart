import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldMolecule extends StatelessWidget {
  const ScaffoldMolecule(
      {required this.child,
      // required this.inputBlockerViewModel,
      this.title,
      this.showLeadingButton = false,
      this.leadingButtonLogo = const Icon(Icons.arrow_back),
      this.leadingButtonOnTap,
      this.leadingButton,
      this.trailing,
      this.appBarElevated = false,
      this.backgroundColor,
      this.floatingActionButton,
      super.key});

  final Widget child;
  // final InputBlockerViewModel inputBlockerViewModel;
  final String? title;

  /// Show leading button, which is back button by default
  final bool showLeadingButton;

  /// Change the logo for the leading button, which is the back logo by default
  final Widget leadingButtonLogo;

  /// Change the onTap for the leading button, which is context.pop() by default
  final void Function()? leadingButtonOnTap;

  /// Override the leading button by supplying a widget.
  /// If this is not null, showLeadingButton, leadingButtonLogo and leadingButtonOnTap are ignored
  final Widget? leadingButton;

  final Color? backgroundColor;

  /// Trailing widget
  final Widget? trailing;

  final Widget? floatingActionButton;

  /// No shadow or color if set to false.
  final bool appBarElevated;

  @override
  Widget build(BuildContext context) {
    bool showAppBar = showLeadingButton || (title != null) || trailing != null;
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              automaticallyImplyLeading: false,
              elevation: appBarElevated ? null : 0,
              backgroundColor: appBarElevated ? null : Colors.transparent,
              leading: leadingButton ??
                  (showLeadingButton
                      ? IconButton(
                          onPressed: () {
                            leadingButtonOnTap?.call();
                            if (leadingButtonOnTap == null) {
                              context.pop();
                            }
                          },
                          icon: leadingButtonLogo,
                        )
                      : null),
              actions: trailing == null ? null : [trailing!],
              title: title == null ? null : Text(title!),
            )
          : null,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: child),
        ],
      )),
    );
  }
}
