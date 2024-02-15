import 'package:eco_toss/common_imports.dart';
import 'package:eco_toss/data/user/i_user_repository.dart';

@injectable
class NameViewModel extends ChangeNotifier {
  NameViewModel(this._userRepository);
  final IUserRepository _userRepository;

  void setPlayerName(String name) {
    _userRepository.setPlayerName(name);
    notifyListeners();
  }

  Future<String> get playerName async {
    final name = await _userRepository.playerName;
    return name ?? 'Crunchy Granola';
  }
}
