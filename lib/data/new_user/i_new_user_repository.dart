abstract class INewUserRepository {
  Future<bool> get hasPlayedTutorial;
  Future<bool> get hasOnboarded;
  Future<void> setHasPlayedTutorial(bool _);
  Future<void> setHasOnboarded(bool _);
}
