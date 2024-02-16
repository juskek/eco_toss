abstract class IScoreRepository {
  Future<int?> get highScore;

  Future<void> setHighScore(int _);
}
