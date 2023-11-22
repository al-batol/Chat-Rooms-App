
import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/settings/domain/repositories/settings_repository.dart';

class UpdateUserProfile {
  final SettingsRepository _settingsRepository;

  const UpdateUserProfile(this._settingsRepository);

  ResultVoid call(
      {required String userId, String? photo, String? name, String? bio}) async {
    return await _settingsRepository.updateUserProfile(
      userId: userId,
      photo: photo,
      name: name,
      bio: bio,
    );
  }
}
