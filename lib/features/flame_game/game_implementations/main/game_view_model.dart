import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/leaderboard/i_leaderboard_repository.dart';
import 'package:eco_toss/data/score/i_score_repository.dart';
import 'package:eco_toss/data/user/i_user_repository.dart';

@injectable
class GameViewModel extends ChangeNotifier {
  GameViewModel(
      this._scoreRepository, this._leaderboardRepository, this._userRepository);

  final IScoreRepository _scoreRepository;
  final ILeaderboardRepository _leaderboardRepository;
  final IUserRepository _userRepository;

  int? _previousHighScore;

  Future<void> getPreviousHighScore() async {
    _previousHighScore = await _scoreRepository.highScore;
    _previousHighScore ??= 0;
  }

  void setPreviousHighScore(int _) {
    _previousHighScore = _;
  }

  int get previousHighScore {
    assert(_previousHighScore != null);
    return _previousHighScore!;
  }

  Future<void> setHighScore(int _) async {
    await _scoreRepository.setHighScore(_);
  }

  Future<void> submitHighScore() async {
    final currentHighScore = await _scoreRepository.highScore;
    final userId = await _userRepository.userId;
    final userName = await _userRepository.playerName;
    assert(currentHighScore != null);
    assert(userName != null);
    _leaderboardRepository.postEntry(userId, userName!, currentHighScore!);
  }

  BinType _currentBinType = BinType.general;

  void cycleBins() {
    _currentBinType =
        BinType.values[(_currentBinType.index + 1) % BinType.values.length];
    notifyListeners();
  }
}

enum BinType {
  general,
  paper,
  plastic,
  glass,
  metal,
}
