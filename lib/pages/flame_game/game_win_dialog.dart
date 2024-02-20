import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../atomic/palette.dart';
import '../leaderboard_page/levels.dart';

/// This dialog is shown when a level is completed.
///
/// It shows what time the level was completed in and if there are more levels
/// it lets the user go to the next level, or otherwise back to the level
/// selection screen.
class GameWinDialog extends StatelessWidget {
  const GameWinDialog({
    super.key,
    required this.level,
    required this.levelCompletedIn,
  });

  /// The properties of the level that was just finished.
  final GameLevel level;

  /// How many seconds that the level was completed in.
  final int levelCompletedIn;

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
              'Well done!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'You completed level ${level.number} in $levelCompletedIn seconds.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (level.number < gameLevels.length) ...[
              TextButton(
                onPressed: () {
                  context.go('/play/session/${level.number + 1}');
                },
                child: const Text('Next level'),
              ),
              const SizedBox(height: 16),
            ],
            TextButton(
              onPressed: () {
                context.go('/play');
              },
              child: const Text('Level selection'),
            ),
          ],
        ),
      ),
    );
  }
}
