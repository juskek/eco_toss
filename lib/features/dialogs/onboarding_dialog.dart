import 'package:eco_toss/atomic/atoms/dialog_atom.dart';
import 'package:eco_toss/atomic/atoms/spacer_atom.dart';
import 'package:flutter/material.dart';

class OnboardingDialog extends StatelessWidget {
  const OnboardingDialog({
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
            "Great job!",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SpacerAtom.medium(),
          const Text(
            "Now that you've learned the basics, recyle away!",
            textAlign: TextAlign.center,
          ),
          const SpacerAtom.medium(),
          FilledButton(
            onPressed: onPressed,
            child: const Text("Let's go!"),
          ),
        ],
      ),
    );
  }
}
