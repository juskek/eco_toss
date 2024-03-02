import 'package:eco_toss/atomic/atoms/spacer_atom.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_list.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../atomic/palette.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final leaderboardViewModel = context.watch<LeaderboardViewModel>();
    final levelTextStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leaderboard',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SpacerAtom.small(),
            FutureBuilder(
              future: leaderboardViewModel.userRank,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    snapshot.data == null
                        ? "Unranked"
                        : 'Rank ${snapshot.data.toString()}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                } else {
                  return const LinearProgressIndicator();
                }
              },
            ),
            const SpacerAtom.small(),
            FutureBuilder(
              future: leaderboardViewModel.userName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return CircleAvatar(
                      radius: 50,
                      child: Text(
                          snapshot.data
                              .toString()
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 40,
                          )));
                } else {
                  return const CircleAvatar(
                    radius: 50,
                  );
                }
              },
            ),
            const SpacerAtom.small(),
            FutureBuilder(
              future: leaderboardViewModel.userName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  }
                  return Text(
                    snapshot.data.toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                } else {
                  return const LinearProgressIndicator();
                }
              },
            ),
            const SpacerAtom.small(),
            FutureBuilder(
              future: leaderboardViewModel.userScore,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('Play a game to set your highscore!');
                  }

                  return Text(
                    'Score: ${snapshot.data.toString()}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                } else {
                  return const LinearProgressIndicator();
                }
              },
            ),
            const SpacerAtom.small(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 16),
              ],
            ),
            const Divider(),
            Expanded(
              child: SizedBox(
                width: 450,
                child: LeaderboardList(
                    leaderboardViewModel: leaderboardViewModel,
                    levelTextStyle: levelTextStyle),
              ),
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('Back'),
            ),
            const SpacerAtom.large(),
          ],
        ),
      ),
    );
  }
}
