import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../atomic/palette.dart';

class WelcomeDialog extends StatelessWidget {
  const WelcomeDialog({
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
            TextButton(
              onPressed: onPressed,
              child: const Text("Show me the basics!"),
            ),
          ],
        ),
      ),
    );
  }
}
