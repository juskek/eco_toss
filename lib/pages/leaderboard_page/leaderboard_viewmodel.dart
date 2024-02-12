import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/leaderboard/i_leaderboard_repository.dart';
import 'package:eco_toss/data/user/i_user_repository.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';

class LeaderboardViewModel extends ChangeNotifier {
  LeaderboardViewModel(this._userRepository, this._leaderboardRepository);
  final IUserRepository _userRepository;
  final ILeaderboardRepository _leaderboardRepository;

  List<LeaderboardEntry> get leaderboardEntries =>
      _leaderboardRepository.entries;

  String get userName {
    assert(_userRepository.ecoTossUser.name != null);
    return _userRepository.ecoTossUser.name!;
  }

  LeaderboardEntry? _leaderboardEntryCache;

  int? userRank;

  int get userScore {
    for (var i = 0; i <= leaderboardEntries.length; i++) {
      final leaderboardEntry = leaderboardEntries[i];

      if (leaderboardEntry.userId == _userRepository.ecoTossUser.userId) {
        _leaderboardEntryCache = leaderboardEntry;
        userRank = i + 1;
        return _leaderboardEntryCache!.score;
      }
    }

    throw Error();
  }
}
