import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/score/i_score_repository.dart';

@injectable
class GameViewModel extends ChangeNotifier {
  GameViewModel(this._scoreRepository);

  final IScoreRepository _scoreRepository;

  int? _previousHighScore;

  Future<void> getPreviousHighScore() async {
    _previousHighScore = await _scoreRepository.highScore;
    _previousHighScore ??= 0;
  }

  int get previousHighScore {
    assert(_previousHighScore != null);
    return _previousHighScore!;
  }

  Future<void> setHighScore(int _) async {
    await _scoreRepository.setHighScore(_);
  }
}
