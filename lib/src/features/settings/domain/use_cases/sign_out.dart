import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/settings/domain/repositories/settings_repository.dart';

class SignOut {
  final SettingsRepository _settingsRepository;

  const SignOut(this._settingsRepository);

  ResultVoid call() async {
    return await _settingsRepository.signOut();
  }
}
