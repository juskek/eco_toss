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

  final ValueNotifier<BinType> _currentBinType = ValueNotifier(BinType.general);

  ValueNotifier<BinType> get currentBinType => _currentBinType;

  void cycleBins() {
    _currentBinType.value = BinType
        .values[(_currentBinType.value.index + 1) % BinType.values.length];
    notifyListeners();
  }

  final ValueNotifier<ThrowableType> _currentThrowableType =
      ValueNotifier(ThrowableType.paperBall);

  ValueNotifier<ThrowableType> get currentThrowableType =>
      _currentThrowableType;

  void cycleThrowables() {
    _currentThrowableType.value = ThrowableType.values[
        (_currentThrowableType.value.index + 1) % ThrowableType.values.length];
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

enum ThrowableType {
  banana,
  can,
  glassBottle,
  paperBall,
  plasticBottle,
}
