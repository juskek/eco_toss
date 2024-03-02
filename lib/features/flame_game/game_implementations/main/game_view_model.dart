import 'dart:math';

import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/leaderboard/i_leaderboard_repository.dart';
import 'package:eco_toss/data/score/i_score_repository.dart';
import 'package:eco_toss/data/user/i_user_repository.dart';
import 'package:eco_toss/features/flame_game/game_implementations/main/utils.dart';

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

  final ValueNotifier<BinType> _currentBinType = ValueNotifier(BinType.paper);

  ValueNotifier<BinType> get currentBinType => _currentBinType;

  final ValueNotifier<ThrowableType> _currentThrowableType =
      ValueNotifier(ThrowableType.paperBall);

  ThrowableType get currentThrowableType => _currentThrowableType.value;

  void cycleThrowablesRandomly() {
    int randomIndex = Random().nextInt(ThrowableType.values.length);
    _currentThrowableType.value = ThrowableType.values[randomIndex];

    _currentBinType.value =
        getCorrectBinTypeForThrowable(_currentThrowableType.value);

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
