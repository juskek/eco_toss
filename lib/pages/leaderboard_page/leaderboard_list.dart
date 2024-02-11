import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_viewmodel.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({
    super.key,
    required this.leaderboardViewModel,
    required this.levelTextStyle,
  });

  final LeaderboardViewModel leaderboardViewModel;
  final TextStyle? levelTextStyle;

  @override
  Widget build(BuildContext context) {
    final leaderboardListTiles =
        List.generate(leaderboardViewModel.leaderboardEntries, (index) {
      final rank = index + 1;
      final leaderboardEntry = leaderboardEntries[index];
      return ListTile(
        enabled: false,
        leading: Text(
          rank.toString(),
          style: levelTextStyle,
        ),
        title: Row(
          children: [
            const CircleAvatar(),
            Text(
              leaderboardEntry.name,
              style: levelTextStyle,
            ),
            const Expanded(child: SizedBox()),
            Text(
              leaderboardEntry.score,
              style: levelTextStyle,
            ),
          ],
        ),
      );
    });

    return ListView(
      children: leaderboardListTiles,
    );
  }
}
