import 'package:eco_toss/atomic/palette.dart';
import 'package:eco_toss/atomic/wobbly_button.dart';
import 'package:eco_toss/features/name/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings.color,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: ListView(
                  children: const [
                    _gap,
                    Text(
                      "Let's get you set up!",
                      textAlign: TextAlign.center,
                    ),
                    _gap,
                    NameWidget(),
                  ],
                ),
              ),
            ),
            _gap,
            WobblyButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Continue'),
            ),
            _gap,
          ],
        ),
      ),
    );
  }
}
