import 'package:eco_toss/atomic/atoms/dialog_atom.dart';
import 'package:eco_toss/atomic/atoms/spacer_atom.dart';
import 'package:flutter/material.dart';

class WelcomeDialog extends StatelessWidget {
  const WelcomeDialog({
    required this.onPressed,
    super.key,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return DialogAtom(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome to Eco Toss!',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SpacerAtom.medium(),
          const Text(
            "Let's learn how to recycle! First, let's start with the basics.",
            textAlign: TextAlign.center,
          ),
          const SpacerAtom.medium(),
          FilledButton(
            onPressed: onPressed,
            child: const Text("Show me the basics"),
          ),
        ],
      ),
    );
  }
}
