import 'package:eco_toss/atomic/atoms/spacer_atom.dart';
import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_viewmodel.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({
    super.key,
    required this.leaderboardViewModel,
    required this.levelTextStyle,
  });

  final LeaderboardViewModel leaderboardViewModel;
  final TextStyle? levelTextStyle;

  List<Widget> generateLeaderboardListTiles(
      List<LeaderboardEntry> leaderboardEntries) {
    return List.generate(leaderboardEntries.length, (index) {
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
            CircleAvatar(
              child: Text(leaderboardEntry.name.substring(0, 1).toUpperCase()),
            ),
            const SpacerAtom.small(),
            Text(
              leaderboardEntry.name,
              style: levelTextStyle,
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        trailing: Text(
          "Score: ${leaderboardEntry.score}",
          style: levelTextStyle,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: leaderboardViewModel.leaderboardEntries,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final leaderboardEntries = snapshot.data as List<LeaderboardEntry>;

          return ListView(
            children: generateLeaderboardListTiles(leaderboardEntries),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
