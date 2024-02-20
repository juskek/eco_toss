import 'package:eco_toss/atomic/atoms/color_atom.dart';
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
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.3,
        child: Container(
          decoration: BoxDecoration(
            color: ColorAtom.timberwolf,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: ColorAtom.payneGrey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ),
      ),
    );
  }
}
