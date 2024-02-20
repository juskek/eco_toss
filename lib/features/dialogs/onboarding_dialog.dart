import 'package:flutter/material.dart';
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
      child: Container(
        width: 420,
        height: 280,
        color: palette.backgroundPlaySession.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Great job!",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "Now that you've learned the basics, recyle away!",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onPressed,
              child: const Text("Let's go!"),
            ),
          ],
        ),
      ),
    );
  }
}
