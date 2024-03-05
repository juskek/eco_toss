import 'dart:async';
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

  final ValueNotifier<List<BinType>> _currentBinType =
      ValueNotifier([BinType.paper]);

  ValueNotifier<List<BinType>> get currentBinType => _currentBinType;

  final ValueNotifier<int> currentBinIndex = ValueNotifier(0);

  final ValueNotifier<ThrowableType> _currentThrowableType =
      ValueNotifier(ThrowableType.paperBall);

  ThrowableType get currentThrowableType => _currentThrowableType.value;

  Timer? binTypeChangeTimer;

  bool randomlyChangeBins = false;

  void cycleThrowablesRandomly() {
    _currentThrowableType.value =
        ThrowableType.values[Random().nextInt(ThrowableType.values.length)];

    final correctBinType =
        getCorrectBinTypeForThrowable(_currentThrowableType.value);

    if (!randomlyChangeBins) {
      _currentBinType.value = [correctBinType];
      notifyListeners();
      return;
    }

    _currentBinType.value = [
      correctBinType,
      getAnotherRandomBinType(correctBinType)
    ];

    currentBinIndex.value = Random().nextInt(2);

    binTypeChangeTimer ??= Timer.periodic(const Duration(seconds: 2), (timer) {
      currentBinIndex.value = currentBinIndex.value == 0 ? 1 : 0;
    });

    notifyListeners();
  }

  void startRandomBinTypeChanges() {
    randomlyChangeBins = true;
  }

  void stopRandomBinTypeChanges() {
    randomlyChangeBins = false;
    _currentBinType.value = [
      getCorrectBinTypeForThrowable(_currentThrowableType.value)
    ];
    currentBinIndex.value = 0;
  }

  void cancelBinTypeChangeTimer() {
    binTypeChangeTimer?.cancel();
    binTypeChangeTimer = null;
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
