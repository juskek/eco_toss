import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../../atomic/palette.dart';

class OnboardingDialog extends StatelessWidget {
  const OnboardingDialog({
    required this.onPressed,
    super.key,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Center(
      child: NesContainer(
        width: 420,
        height: 280,
        backgroundColor: palette.backgroundPlaySession.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Eco Toss!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "Let's learn how to recycle! First, let's start with the basics.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            NesButton(
              onPressed: onPressed,
              type: NesButtonType.primary,
              child: const Text("Let's go!"),
            ),
          ],
        ),
      ),
    );
  }
}
