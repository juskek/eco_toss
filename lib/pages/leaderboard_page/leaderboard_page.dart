import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../atomic/palette.dart';
import '../../atomic/wobbly_button.dart';
import '../../features/player_progress/player_progress.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    final levelTextStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4);

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection.color,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Leaderboard',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Rank 4',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const CircleAvatar(
              radius: 50,
            ),
            const Text('Crunchy Granola'),
            const Text('20 points'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 50),
            Expanded(
              child: SizedBox(
                width: 450,
                child: ListView(
                  children: [
                    for (var i = 0; i < 50; i++)
                      ListTile(
                        enabled: false,
                        leading: Text(
                          i.toString(),
                          style: levelTextStyle,
                        ),
                        title: Row(
                          children: [
                            const CircleAvatar(),
                            Text(
                              'Rando',
                              style: levelTextStyle,
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              '1234 points',
                              style: levelTextStyle,
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            WobblyButton(
              onPressed: () {
                GoRouter.of(context).go('/');
              },
              child: const Text('Back'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}