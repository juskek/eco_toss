import 'package:eco_toss/pages/leaderboard_page/leaderboard_list.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../atomic/palette.dart';
import '../../atomic/wobbly_button.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final leaderboardViewModel = context.watch<LeaderboardViewModel>();
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
              leaderboardViewModel.userRank,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const CircleAvatar(
              radius: 50,
            ),
            const Text(leaderboardViewModel.userName),
            const Text(leaderboardViewModel.userScore),
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
                child: LeaderboardList(
                    leaderboardViewModel: leaderboardViewModel,
                    levelTextStyle: levelTextStyle),
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
