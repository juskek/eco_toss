import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/leaderboard/i_leaderboard_repository.dart';
import 'package:eco_toss/data/score/i_score_repository.dart';
import 'package:eco_toss/data/user/i_user_repository.dart';
import 'package:eco_toss/pages/leaderboard_page/leaderboard_entry.dart';

@injectable
class LeaderboardViewModel extends ChangeNotifier {
  LeaderboardViewModel(
      this._userRepository, this._leaderboardRepository, this._scoreRepository);
  final IUserRepository _userRepository;
  final ILeaderboardRepository _leaderboardRepository;
  final IScoreRepository _scoreRepository;

  Future<List<LeaderboardEntry>> get leaderboardEntries =>
      _leaderboardRepository.entries;

  String get userName {
    assert(_userRepository.ecoTossUser.name != null);
    return _userRepository.ecoTossUser.name!;
  }

  Future<int?> get userRank async =>
      _leaderboardRepository.getUserRank(await _userRepository.userId);

  int? get userScore => _scoreRepository.highScore;
}
